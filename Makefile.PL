use ExtUtils::MakeMaker;
use Config;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
my %opts = (
	    'NAME' => 'Math::Cephes',
	    'DIR' => 'libmd',
	    'VERSION_FROM' => 'lib/Math/Cephes.pm',
	    'EXE_FILES' => [ pmath ],
	    'dist'   => {
			 SUFFIX   => 'gz',
			 COMPRESS => 'gzip -9f',
			},
	   );

if ($ExtUtils::MakeMaker::VERSION >= 5.43) {
   $opts{ABSTRACT} = 'Perl interface to the math cephes library';
   $opts{AUTHOR} = 'Randy Kobes <randy@theory.uwinnipeg.ca>';
   $opts{CAPI} = 'TRUE' if $Config::Config{archname} =~ /-object\b/i;
}


WriteMakefile(%opts);

print <<'END';

The file libmd/mconf.h contains some machine dependent definitions. 
These have been set for linux/Win32, but for other systems some
manual editing of this file may be required.

END
