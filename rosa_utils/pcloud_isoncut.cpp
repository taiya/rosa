#include <assert.h>
#include "vector.h"
#include <iostream>
#include <math.h>
#include "mex.h"
/// data wrapper for a Nx3 set of points
class DataWrapper{
	private: 
	double*   	     data;
	int       		 npoints;
	const static int ndim = 3; 
		
	public:
		
	void factory( double* data, int npoints ){
		this->data 	  = data;
		this->npoints = npoints;
	}
	/** 
	 *  Data retrieval function
	 *  @param a address over npoints
	 *  @param b address over the dimensions
	 */
	inline double operator()(int a, int b){
		assert( a<npoints );
		assert( b<ndim );
		return data[ a + npoints*b ];
	}
	/// retrieve a single point at offset a, in a vector (preallocated structure)
	inline void operator()(int a, vector<double>& p){
		assert( a<npoints );
		assert( (int)p.size() == ndim );
		p[0] = data[ a + 0*npoints ];
		p[1] = data[ a + 1*npoints ];
		p[2] = data[ a + 2*npoints ];
	}
	int length(){
		return this->npoints;
	}
};

/// perform the within distance query on a point cloud
void distance_query( DataWrapper& data, const vector<double>& Pp, const vector<double>& Np, double delta, double* isoncut ){
	vector<double> P(3);
	for (int pIdx=0; pIdx < data.length(); pIdx++) {
		// retrieve current point
		data( pIdx, P );
		// check distance
		if( fabs( Np[0]*(Pp[0]-P[0]) + Np[1]*(Pp[1]-P[1]) + Np[2]*(Pp[2]-P[2]) ) < delta )
			isoncut[pIdx] = 1;
	}
}
	

#ifndef CPPONLY
#include "mex.h"

void retrieve_data( const mxArray* mx, DataWrapper& data ){
	data.factory( mxGetPr(mx), mxGetM(mx) );
	assert( mxGetN(mx) == 3 );
}
void retrieve_Pp( const mxArray* mx, vector<double>& Pp ){
	if( mxGetN( mx ) != 3 || mxGetM(mx) != 1 )
		mexErrMsgTxt("vararg{2} must be a [1x3] point givin the plane offset\n");
	double* Pp_mx = mxGetPr( mx );
	Pp[0] = Pp_mx[0];
	Pp[1] = Pp_mx[1];
	Pp[2] = Pp_mx[2];	
}
void retrieve_Np( const mxArray* mx, vector<double>& Np ){
	if( mxGetN( mx ) != 3 || mxGetM(mx) != 1 )
		mexErrMsgTxt("vararg{3} must be a [1x3] vector giving the plane orientation\n");
	double* Np_mx = mxGetPr( mx );
	Np[0] = Np_mx[0];
	Np[1] = Np_mx[1];
	Np[2] = Np_mx[2];
}
void retrieve_delta( const mxArray* mx, double& delta ){
	if( mxGetN(mx) != 1 && mxGetM(mx) != 1 )
		mexErrMsgTxt("vararg{3} must be a scalar giving maximum distance from plane\n");
	delta =	mxGetScalar(mx);
}

/// matlab entry point
void mexFunction(int nlhs, mxArray * plhs[], int nrhs, const mxArray * prhs[]){      
	// retrieve the data
	DataWrapper data;
	retrieve_data( prhs[0], data );
	// retrieve the query plane
	vector<double> Pp(3,0), Np(3,0);
	double delta = 0;
	retrieve_Pp( prhs[1], Pp );
	retrieve_Np( prhs[2], Np );
	retrieve_delta( prhs[3], delta );
	
	// perform a distance test on every point
	plhs[0] = mxCreateDoubleMatrix(data.length(),1,mxREAL);
    double* isoncut = mxGetPr( plhs[0] );
    distance_query( data, Pp, Np, delta, isoncut );
}
#endif


// using namespace std;
// #include <iostream>
// int test1(){
// 	// create data
// 	double datad[60] = { 0.513, 0.460, 0.350, 0.095, 0.434, 0.709, 0.116, 0.078, 0.369, 0.034, 0.192, 0.471, 0.145, 0.718, 0.662, 0.432, 0.446, 0.508, 0.528, 0.573, 
// 				 	     0.361, 0.336, 0.173, 0.086, 0.393, 0.804, 0.011, 0.233, 0.934, 0.227, 0.786, 0.411, 0.119, 0.634, 0.862, 0.158, 0.601, 0.118, 0.626, 0.835, 
// 				 	     0.940, 0.416, 0.272, 0.928, 0.921, 0.542, 0.813, 0.166, 0.320, 0.658, 0.002, 0.629, 0.785, 0.295, 0.790, 0.216, 0.403, 0.802, 0.862, 0.144 };
// 	DataWrapper data;
// 	data.factory( datad, 20 );
// 	
// 	vector<double> Pp(3,0); Pp[0]=.5; Pp[1]=.5; Pp[2]=.5; 
// 	vector<double> Np(3,0); Np[0]=0;  Np[1]=0;  Np[2]=1;
// 	double delta = .3;
// 
// 	vector<int> indexes(0,0);
// 	distance_query( data, Pp, Np, delta, indexes );
// 	
// 	for (int iIdx=0; iIdx < (int)indexes.size(); iIdx++)
// 		cout << indexes[iIdx] + 1<< " ";
// 	cout << endl;
// 	
// 	return 0;
// }
// int main (int argc, char * const argv[]) {
// 	return test1();
// }
