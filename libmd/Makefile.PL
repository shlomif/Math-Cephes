use ExtUtils::MakeMaker;
use Config;
use File::Copy;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

my $from = ($Config{archname} =~ /sun4-solaris|sparc/) ?
    'mconf.h.sol' : 'mconf.h.gen';
my $to = 'mconf.h';
copy($from, $to) unless (-e $to);

$from = ($Config{cc} =~ /^cl/) ? 'setpmsvc.c.win32' : 'setprec.c.unix';
$to = 'setprec.c';
copy($from, $to) unless (-e $to);

opendir(DIR, ".") or die "Cannot open .: $!\n";
my @objects = map {s/\.c$/.o/; $_} grep { /\.c$/ } readdir DIR;
closedir DIR;
my $OLDFLAGS = $Config{ccflags};

my %opts = (
            'NAME'      => 'Math::Cephes',
#            'VERSION_FROM' => '../lib/Math/Cephes.pm', # finds $VERSION
	    'LIBS'	=> [''],   # e.g., '-lm' 
	    'DEFINE'	=> '',     # e.g., '-DHAVE_SOMETHING' 
	    'INC'	=> '',     # e.g., '-I/usr/include/other' 
	    'OBJECT' => join(' ', @objects),
	    'dist'   => {
			 SUFFIX   => 'gz',
			 COMPRESS => 'gzip -9f',
			},
	   );

if ($^O =~ /Win32/) {
   (my $ccflags = $Config{ccflags}) =~ s!-O\d+!!;
   (my $optimize = $Config{optimize}) =~ s!-O\d+!!;
   $opts{CCFLAGS} = $ccflags;
   $opts{OPTIMIZE} = $optimize;
}

if ($Config{gccversion}) {
   $opts{CCFLAGS} = "$OLDFLAGS -g -Wall -fno-builtin";
}



sub MY::post_constants {
   my $postconstant;
   my $AS = '$(AS)';
   my $archname = $Config{archname};
   if ($archname =~ /i\d+-linux/) {
      $postconstant = << "END";

sqrt.o: sqrtelf.387
	$AS -o sqrt.o sqrtelf.387

setprec.o: setprelf.387
	$AS -o setprec.o setprelf.387

Cephes_wrap.o: Cephes_wrap.c
	$Config{cc} -o Cephes_wrap.o $OLDFLAGS -I\$(PERL_INC) \$(DEFINE) -c Cephes_wrap.c

END
   }
    elsif ($archname =~ /sun4-solaris|sparc/) {
       $postconstant = << "END";

sqrt.o: sqrt.spa
	$AS -o sqrt.o sqrt.spa

END
   }
   else {
       $postconstant = '';
   } 
  $postconstant;
}

WriteMakefile(%opts);

