use ExtUtils::MakeMaker;
use Config;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
my @clean = qw(libmd/setprec.c libmd/mconf.h);

my %opts = (
	    'NAME' => 'Math::Cephes',
            'DIR' => ['libmd'],
	    'VERSION_FROM' => 'lib/Math/Cephes.pm',
	    'EXE_FILES' => [ pmath ],
	    'dist'   => {
			 SUFFIX   => 'gz',
			 COMPRESS => 'gzip -9f',
			},
	    clean => { FILES => "@clean"},
	   );

if ($ExtUtils::MakeMaker::VERSION >= 5.43) {
   $opts{ABSTRACT} = 'Perl interface to the math cephes library';
   $opts{AUTHOR} = 'Randy Kobes <randy@theory.uwinnipeg.ca>';
   $opts{CAPI} = 'TRUE' if $Config::Config{archname} =~ /-object\b/i;
}


WriteMakefile(%opts);

my $arch = $Config{archname};
my $message;

if ($arch =~ /sun4-solaris|sparc/) {
  $message = <<'END';

A file libmd/mconf.h, which contains machine-dependent
definitions, has been used which is known to work with some 
versions of Solaris/gcc. If there are some problems with 
the tests, some manual editing of this file may be needed.

END

}

elsif ($arch =~ /linux|Win32/) {
  $message = <<'END';

A file libmd/mconf.h, which contains machine-dependent
definitions, has been used which is known to work with linux
and ActivePerl compatible Win32. If there are some problems with
the tests, some manual editing of this file may be needed.

END

}

else {
    $message = <<'END';

The file libmd/mconf.h, which contains machine-dependent
definitions, may require some manual editing for your platform.

END

}

print $message;
