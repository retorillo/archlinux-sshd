FROM retorillo/archlinux
RUN pacman -S --needed --noconfirm \
  sudo which vim tar grep sed awk wget openssh git
RUN pacman -Sc --noconfirm
ENV EDITOR='vim'
RUN sed -ie 's/^#\(en_US\.UTF-8 UTF-8\)/\1/' /etc/locale.gen \
  && locale-gen
RUN useradd -mU -s /bin/bash docker && echo 'docker:docker' | chpasswd
RUN echo "docker ALL=(ALL:ALL) ALL" | (EDITOR="tee -a" visudo)
RUN echo "AllowUsers docker" >> /etc/ssh/sshd_config
EXPOSE 22
CMD [ ! -f /etc/ssh/ssh_host_rsa_key ] && ssh-keygen -A; /bin/sshd -D
