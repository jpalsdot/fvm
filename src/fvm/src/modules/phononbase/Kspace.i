%{
#include "Kspace.h"
#include "ScatteringKernel.h"
  %}

%include "std_vector.i"

template<class T>
class Kspace
{

 public:

  typedef Vector<T,3> Tvec;
  typedef pmode<T> Tmode;
  typedef shared_ptr<Tmode> Tmodeptr;
  typedef kvol<T> Tkvol;
  typedef shared_ptr<Tkvol> Kvolptr;
  typedef vector<Kvolptr> Volvec;
  typedef Kspace<T> TKspace;
  typedef typename Tmode::Reflection Reflection;
  typedef typename Tmode::Reflptr Reflptr;
  typedef typename Tmode::Refl_pair Refl_pair;
  typedef typename Tmode::Refl_Map Refl_Map;

  Kspace(T a, T tau, T vgmag, T omega, int ntheta, int nphi, const bool full);
  Kspace(const char* filename,const int dimension);
  Kspace(const char* filename,const int dimension,const bool normal);
  int getlength();
  int gettotmodes();
  T getDK3() ;
  T calcSpecificHeat(T Tl);
  T calcSpecificHeat(T Tl,const int m);
  T findKnStats(const T length);
  T FindBallisticHeatRate(const Tvec Af,const T T1,const T T2);
  ArrayBase* getVelocities();
  ArrayBase* getReflectionArray(const Mesh& mesh, const int FgId);
  ArrayBase* getHollandConductivity(const T Tl);
  void setTransmission(Kspace<T>& toKspace, ArrayBase* freqBins, ArrayBase* transArray);
  T calcBallisticInterface(Kspace<T>& kspace1, const Tvec& An, const T T0, const T T1);
  T calcDiffuseE(Kspace<T>& kspace1, const Tvec& An, const T T0, const T T1);
  void setDOS(DensityOfStates<T>& DOS);
  void setScattKernel(ScatteringKernel<T>& Sk);
  void setCp(const T cp);
  void setCpNonGray(const T Tl);
  Array<T>& getFreqArray();

  %extend{
    std::vector<Kspace<T>*>& MakeList()
      {
	std::vector<Kspace<T>*>* newList=new std::vector<Kspace<T>*>();
	newList->push_back(self);
	return *newList;
      }

    void AddToList(std::vector<Kspace<T>*>& toList)
    {toList.push_back(self);}
  }
  
 private:
  
  Kspace(const Kspace&);
  //num volumes
  int _length;
  Volvec _Kmesh;
  T _totvol; 
  TransmissionMap _trasMap;
  DensityOfStates* _DOS;
  ScatteringKernel* _ScattKernel;
  
};

template <class T>
class ScatteringKernel
{
  
 public:
  ScatteringKernel(Kspace<T>& kspace);
  void ReadType1(const char* NamePhonon2, const char* NamePhonon3);
  void ReadType2(const char* NamePhonon2, const char* NamePhonon3);
  void updateSourceTermTest(const T Tl);
  void addFreqs();

 private:
  ScatteringKernel(const ScatteringKernel&);
  Kspace<T>& _kspace;
  KSConnectivity<T> _type1Collisions;
  KSConnectivity<T> _type2Collisions;
  T _maxPhi;
  T _maxDkl;

};


%template(KspaceA) Kspace< ATYPE_STR >;
%template(ScattKernel) ScatteringKernel< ATYPE_STR >;

typedef std::vector<Kspace<ATYPE_STR>*> TkspList;
%template(TkspList) std::vector<Kspace<ATYPE_STR>*>;
