#ifndef _ELECTRICFIELDS_H_
#define _ELECTRICFIELDS_H_


#include "Field.h"
#include "FieldLabel.h"

struct ElectricFields
{
  ElectricFields(const string baseName);

  //Fields in electrastatics

  Field potential;
  Field potential_flux;              /* this is only stored on boundary faces for the purpose */
                                     /* of post processing and applying generic bc*/
  Field potential_gradient;
  Field electric_field;              //potentialGradient vector; 
  Field dielectric_constant;         //permittivity;
  Field total_charge;                 //source term in Poisson equation
                                     //which is the sum of charge[0] and charge[1]
                                     
  Field init_charge;                 //initial charges (not changing with time)
  Field force;

  //Fields in charge transport

  Field conduction_band;
  Field valence_band;
  Field electron_totaltraps;          //number of electron traps at each cell
  //Field electron_trap;              //electron density in traps
  //Field electron_band;              //electron density in conduction band
  Field free_electron_capture_cross; //free electron capture cross section
  Field transmission;
  Field electron_velocity;
  Field charge;
  Field chargeFlux;
  Field diffusivity;
  Field convectionFlux;
  Field chargeGradient;
  Field chargeN1;
  Field chargeN2;
  Field zero;                     //used to fill in continuityResidual
  Field one;                      //used to fill in density
 
  Field oneD_column;              //the one dimensional columns used in dielectric chargine 1D model
  
};

#endif
