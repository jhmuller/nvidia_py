export ENV=$1
if [ -z "$1" ]
  then
    echo "no arg #1 supplied"
    return
  else
    echo "ENV is ${ENV} or without braces $ENV"
fi

echo "ENV set to ${ENV}"


echo "ENV is ${ENV} or without braces  $ENV"
echo "==="
export ISENV=$(conda env list | grep ${ENV} )
echo $ISENV
echo "======"



conda  clean --all --yes
echo  "creating conda env ${ENV}"
conda create -n $ENV python=3.8
conda activate $ENV
export NOWISENV=$(conda env list | grep ${ENV})


echo "-- pip --"
conda install pip --yes

echo $(which pip)
echo $(conda  info | sed 2q)
export CUDAVER=$(nvcc --version | awk -F',' '/release/ {print $2}' | awk '{print $2}' |  sed 's/\.//g')
echo "==CudaVer $CUDAVER"

echo "==ipython and jupyter=="
conda install -y ipython jupyter

echo "== jupyterlab =="
conda install -y -c conda-forge jupyterlab

echo $(which pip)
echo $(conda  info | sed 2q)
echo  "==done pip =="

echo "==scipy and scikit-lerarn=="
conda install -y scipy  scikit-learn statsmodels
echo "==pandas matplotlib numpy=="
conda install  -y  pandas matplotlib numpy
echo "== nbconvert =="
pip install nbconvert

echo "== plotnine =="
pip install -y  plotnine

echo "== networkx =="
pip install  -y networkx


pip install -y pygpu
pip install -U nvgpu
conda clean --all -y
echo "Done  $(date)"
