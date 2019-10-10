FROM ubuntu
COPY . .
RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y openssh-server && \
  apt-get install -y curl && \
  apt-get install -y gcc && \
  apt-get install -y linux-headers-generic && \
  apt-get install -y gnupg && \
  apt-get install -y cmake && \
  wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin && \
  mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
  wget http://developer.download.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda-repo-ubuntu1804-10-1-local-10.1.243-418.87.00_1.0-1_amd64.deb && \
  dpkg -i cuda-repo-ubuntu1804-10-1-local-10.1.243-418.87.00_1.0-1_amd64.deb && \
  apt-key add /var/cuda-repo-10-1-local-10.1.243-418.87.00/7fa2af80.pub && \
  apt-get update && \
  apt-get -y install cuda && \
  wget ftp://ftp.gromacs.org/pub/gromacs/gromacs-2020-beta1.tar.gz && \
  tar xfz gromacs-2020-beta1.tar.gz && \
  cd gromacs-2020-beta1 && \
  mkdir build && \
  cd build && \
  cmake .. -DGMX_BUILD_OWN_FFTW=ON -DREGRESSIONTEST_DOWNLOAD=ON && \
  make && \
  make check && \
  make install && \
  /bin/bash -c "source /usr/local/gromacs/bin/GMXRC"

EXPOSE 22
