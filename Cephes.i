%include typemaps.i
%module Cephes

%{
typedef struct {
    double n;
    double d;
} fract;

typedef struct {
    double r;
    double i;
} cmplx;

%}

typedef struct {
	double r;
	double i;
	%addmethods {
	  cmplx(double r=0, double i=0) {
   	    cmplx *c;
  	    c = (cmplx *) malloc(sizeof(cmplx));
    	    c->r = r;
    	    c->i = i;
    	    return c;
	  }
	  ~cmplx() {
	    free(self);
	  }
	}
} cmplx;

typedef struct {
	double n;
	double d;	
	%addmethods {
	  fract(double n=0, double d=1) {
   	    fract *f;
  	    f = (fract *) malloc(sizeof(fract));
    	    f->n = n;
    	    f->d = d;
    	    return f;
	  }
	  ~fract() {
	    free(self);
	  }
	}
} fract;


extern double MACHEP;
extern double MAXLOG;
extern double MINLOG;
extern double MAXNUM;
extern double PI;
extern double PIO2;
extern double PIO4;
extern double SQRT2;
extern double SQRTH;
extern double LOG2E;
extern double SQ2OPI;
extern double LOGE2; 
extern double LOGSQ2;
extern double THPIO4;
extern double TWOOPI;

extern double acosh ( double x );
extern int airy ( double x, double *OUTPUT, double *OUTPUT, double *OUTPUT, double *OUTPUT );
extern double asin ( double x );
extern double acos ( double x );
extern double asinh ( double x );
extern double atan ( double x );
extern double atan2 ( double y, double x );
extern double atanh ( double x );
extern double bdtrc ( int k, int n, double p );
extern double bdtr ( int k, int n, double p );
extern double bdtri ( int k, int n, double y );
extern double beta ( double a, double b );
extern double lbeta ( double a, double b );
extern double btdtr ( double a, double b, double x );
extern double cbrt ( double x );
extern double chbevl ( double x, void *P, int n );
extern double chdtrc ( double df, double x );
extern double chdtr ( double df, double x );
extern double chdtri ( double df, double y );
extern void clog ( cmplx *z, cmplx *w );
extern void cexp ( cmplx *z, cmplx *w );
extern void csin ( cmplx *z, cmplx *w );
extern void ccos ( cmplx *z, cmplx *w );
extern void ctan ( cmplx *z, cmplx *w );
extern void ccot ( cmplx *z, cmplx *w );
extern void casin ( cmplx *z, cmplx *w );
extern void cacos ( cmplx *z, cmplx *w );
extern void catan ( cmplx *z, cmplx *w );
extern void csinh ( cmplx *z, cmplx *w );
extern void casinh ( cmplx *z, cmplx *w );
extern void ccosh ( cmplx *z, cmplx *w );
extern void cacosh ( cmplx *z, cmplx *w );
extern void ctanh ( cmplx *z, cmplx *w );
extern void catanh ( cmplx *z, cmplx *w );
extern void cpow ( cmplx *a, cmplx *z, cmplx *w );
extern void radd ( fract *a, fract *b, fract *c );
extern void rsub ( fract *a, fract *b, fract *c );
extern void rmul ( fract *a, fract *b, fract *c );
extern void rdiv ( fract *a, fract *b, fract *c );
extern double euclid ( double *BOTH, double *BOTH);
extern void cadd ( cmplx *a, cmplx *b, cmplx *c );
extern void csub ( cmplx *a, cmplx *b, cmplx *c );
extern void cmul ( cmplx *a, cmplx *b, cmplx *c );
extern void cdiv ( cmplx *a, cmplx *b, cmplx *c );
extern void cmov ( void *a, void *b );
extern void cneg ( cmplx *a );
extern double cabs ( cmplx *z );
extern void csqrt ( cmplx *z, cmplx *w );
extern double hypot ( double x, double y );
extern double cosh ( double x );
extern double dawsn ( double xx );
extern double ellie ( double phi, double m );
extern double ellik ( double phi, double m );
extern double ellpe ( double x );
extern int ellpj ( double u, double m, double *OUTPUT, double *OUTPUT, double *OUTPUT, double *OUTPUT );
extern double ellpk ( double x );
extern double exp ( double x );
extern double exp10 ( double x );
/* extern double exp1m ( double x ); */
extern double exp2 ( double x );
extern double expn ( int n, double x );
extern double ei ( double x );
extern double fabs ( double x );
extern double fac ( int i );
extern double fdtrc ( int ia, int ib, double x );
extern double fdtr ( int ia, int ib, double x );
extern double fdtri ( int ia, int ib, double y );
extern double ceil ( double x );
extern double floor ( double x );
extern double frexp ( double x, int *OUTPUT);
/* extern double frexp ( double x, int *pw2 ); */
extern double ldexp ( double x, int pw2 );
/* extern int signbit ( double x ); */
/* extern int isnan ( double x ); */
/* extern int isfinite ( double x ); */
extern int fresnl ( double xxa, double *OUTPUT, double *OUTPUT);
extern double gamma ( double x );
extern double lgam ( double x );
extern double gdtr ( double a, double b, double x );
extern double gdtrc ( double a, double b, double x );
extern double hyp2f1 ( double a, double b, double c, double x );
extern double hyperg ( double a, double b, double x );
extern double hyp2f0 ( double a, double b, double x, int type, double *OUTPUT );
extern double i0 ( double x );
extern double i0e ( double x );
extern double i1 ( double x );
extern double i1e ( double x );
extern double igamc ( double a, double x );
extern double igam ( double a, double x );
extern double igami ( double a, double y0 );
extern double incbet ( double aa, double bb, double xx );
extern double incbi ( double aa, double bb, double yy0 );
extern double iv ( double v, double x );
extern double j0 ( double x );
extern double y0 ( double x );
extern double j1 ( double x );
extern double y1 ( double x );
extern double jn ( int n, double x );
extern double jv ( double n, double x );
extern double k0 ( double x );
extern double k0e ( double x );
extern double k1 ( double x );
extern double k1e ( double x );
extern double kn ( int nn, double x );
extern double log ( double x );
extern double log10 ( double x );
extern double log2 ( double x );
extern long lrand ( void );
extern long lsqrt ( long x );
extern int mtherr ( char *name, int code );
extern double polevl ( double x, void *P, int N );
extern double p1evl ( double x, void *P, int N );
extern double nbdtrc ( int k, int n, double p );
extern double nbdtr ( int k, int n, double p );
extern double nbdtri ( int k, int n, double p );
extern double ndtr ( double a );
extern double erfc ( double a );
extern double erf ( double x );
extern double ndtri ( double y0 );
extern double pdtrc ( int k, double m );
extern double pdtr ( int k, double m );
extern double pdtri ( int k, double y );
extern double pow ( double x, double y );
extern double powi ( double x, int nn );
extern double psi ( double x );
extern double rgamma ( double x );
extern double round ( double x );
extern int shichi ( double x, double *OUTPUT, double *OUTPUT );
extern int sici ( double x, double *OUTPUT, double *OUTPUT );
extern double sin ( double x );
extern double cos ( double x );
extern double radian ( double d, double m, double s );
/*
extern int sincos ( double x, double *OUTPUT, double *OUTPUT, int flg );
*/
extern double sindg ( double x );
extern double cosdg ( double x );
extern double sinh ( double x );
extern double spence ( double x );
extern double sqrt ( double x );
extern double stdtr ( int k, double t );
extern double stdtri ( int k, double p );
extern double onef2 ( double a, double b, double c, double x, double *OUTPUT );
extern double threef0 ( double a, double b, double c, double x, double *OUTPUT );
extern double struve ( double v, double x );
extern double tan ( double x );
extern double cot ( double x );
extern double tandg ( double x );
extern double cotdg ( double x );
extern double tanh ( double x );
extern double log1p ( double x );
extern double expm1 ( double x );
extern double cosm1 ( double x );
extern double yn ( int n, double x );
extern double yv ( double n, double x );
extern double zeta ( double x, double q );
extern double zetac ( double x );
extern int drand ( double *OUTPUT );

