ARG IMAGE_FREECAD_DOCKER
FROM ${IMAGE_FREECAD_DOCKER}

# Copy the source code.
ARG FOLDER_SOURCE
COPY ${FOLDER_SOURCE} /mnt/source

# Build FreeCAD
ENV DISPLAY=:0
ENV QT_X11_NO_MITSHM=1
ENV LIBGL_ALWAYS_INDIRECT=1
RUN mkdir -p /mnt/build
RUN /root/build_script.sh

# Update and install base packages.
### Fix apt update error: Could not create temporary file.
RUN chmod 777 /tmp
RUN apt update -y
RUN apt install -y screenfetch
RUN apt install -y curl

# Add special configuration for root.
ADD https://raw.githubusercontent.com/airvzxf/archLinux-installer-and-setup/master/src/laptop_MSI_GT73EVR_7R_Titan_Pro/04-setup/setup-resources/.bashrc /root
RUN curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > /root/.bash_git

# Update and install development packages
#RUN apt install -y mesa-utils libgl1-mesa-glx
RUN apt install -y htop
RUN apt install -y procps
RUN apt install -y vim

# Start the FreeCAD
#ENTRYPOINT /mnt/build/bin/FreeCAD
#ENTRYPOINT sleep 999999
