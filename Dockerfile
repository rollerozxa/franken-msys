FROM archlinux:latest

WORKDIR /

RUN echo -e "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist\n" >> /etc/pacman.conf && \
    pacman -Syu --noconfirm

RUN pacman -S --noconfirm wine cmake ninja pkgconf git wget

RUN curl -L "https://github.com/mstorsjo/llvm-mingw/releases/download/20250114/llvm-mingw-20250114-ucrt-ubuntu-20.04-x86_64.tar.xz" | tar xJkvf - -C "/usr" --strip-components=1

RUN pacman-key --init

RUN curl -o /tmp/msys2-keyring.pkg.tar.zst https://repo.msys2.org/msys/x86_64/msys2-keyring-1~20250214-1-any.pkg.tar.zst && \
    pacman -U --noconfirm /tmp/msys2-keyring.pkg.tar.zst && \
    rm /tmp/msys2-keyring.pkg.tar.zst

RUN echo -e "\n[clang64]\nServer = https://mirror.msys2.org/mingw/clang64/\n" >> /etc/pacman.conf && \
	echo -e "\n[clangarm64]\nServer = https://mirror.msys2.org/mingw/clangarm64/\n" >> /etc/pacman.conf && \
    pacman -Syu --noconfirm
