#include <iostream>
#include <quadrature.h>
using namespace std;

int main(){
  int N1=8,N2=12,N3=10;
  double T2=1.0;
  quadrature<double> myquad1 = quadrature<double>(N1,N2,N3,T2); 
 int option_ur=8,Nr=8,option_theta=1,n_int =4, option_phi=1,nphi_int = 4;
 quadrature<double> myquad2= quadrature<double>(option_ur,Nr,option_theta,n_int,option_phi,nphi_int);
//double density=0.5;
 //double temperature=2.0;
 //double x_velocity=0.1;
 //double y_velocity=0.01;
  return 0;
}
