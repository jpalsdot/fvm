%{
#include "COMETModel.h"
  %}

%include "Model.i"
%include "FloatVarDict.i"

template<class T>
class COMETModel : public Model
{

 public:
  
  typedef Kspace<T> Tkspace;
  typedef map<int,COMETBC<T>*> COMETBCMap; 
  typedef COMETModel<T> TCOMET;
  typedef shared_ptr<TCOMET> TCOMETPtr;

  COMETModel(const MeshList& meshes,const int level,GeomFields& geomFields,
	     Tkspace& kspace,PhononMacro& macro);
  
  void init();
  void advance(int);
  T HeatFluxIntegral(const Mesh& mesh, const int faceGroupId);
  T getWallArea(const Mesh& mesh, const int faceGroupId);
  COMETModelOptions<T>& getOptions();
  COMETBCMap& getBCs();
  
 private:
  
  const int _level; 
  GeomFields& _geomFields;
  Tkspace& _kspace;
  PhononMacro& _macro;
  TCOMET* _finestLevel;
  TCOMET* _coarserLevel;
  TCOMET* _finerLevel;
  PhononBCMap _bcMap;
  PhononModelOptions<T> _options;
  BCfaceList _BFaces;
  BCcellList _BCells;

};

template <class T>
struct COMETBC : public FloatVarDict<T>
{
  string bcType;
}; 

template<class T>
struct COMETModelOptions : public FloatVarDict<T>
{
  bool printNormalizedResiduals;
  bool transient;
  int timeDiscretizationOrder;
  double absTolerance;
  double relTolerance;
  int showResidual;
  int maxLevels;
  string AgglomerationMethod;
  int preSweeps;
  int postSweeps;
};

%template(COMETBCA) COMETBC<ATYPE_STR>;
%template(COMETModelOptionsA) COMETModelOptions<ATYPE_STR>;
%template(COMETBCList) std::vector<COMETBC< ATYPE_STR >* >;
%template(COMETBCsMap) std::map<int,COMETBC< ATYPE_STR >* >;
%template(COMETModelA) COMETModel<ATYPE_STR>;