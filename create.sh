#! /bin/sh

set -e


# Created MagyArchLinux Team

sudo pacman -S cmake docbook2x go i3-wm python-sphinx --needed --noconfirm
yay -S golang-github-godbus-dbus --needed --noconfirm

# rm x86_64/*.tar.xz
rm x86_64/*.tar.zst

pkgs=( polybar polybar-git alsi sutils-git sublime-text-dev dmenu2 brave-bin \
spotify xtitle-git task-spooler ttf-font-awesome-4 libxft-bgra cava lf-bin \
dwm st conky-lua-archers golang-github-godbus-dbus xmonad-log paru-bin tdrop-git)

for i in "${pkgs[@]}"
do

    git clone https://aur.archlinux.org/${i}
    cd $i
    makepkg  -d --skipinteg -c --noconfirm
    cp *.tar.zst ../x86_64/
    cd ..
    rm -rf $i
    echo ""
    echo "-----------"
    echo "Build $i"
    echo "----------"
    echo ""

done

echo -e "\n Magyarch packages. \n"

git clone https://github.com/magyarchlinux/magyarch-pkgbuild.git
cd magyarch-pkgbuild/wallpapers
makepkg  -d --skipinteg -c --noconfirm
mv *.tar.zst ../../x86_64/

cd ../magyarch-xfce4
makepkg  -d --skipinteg -c --noconfirm
mv *.tar.zst ../../x86_64/

cd ../magyarch-lightdm
makepkg  -d --skipinteg -c --noconfirm
mv *.tar.zst ../../x86_64/

cd ../magyarch_xmonad_pacman_hook
makepkg  -d --skipinteg -c --noconfirm
mv *.tar.zst ../../x86_64/

cd ../../
rm -rf magyarch-pkgbuild

cd x86_64
./updaterepo.sh
cd ..

cp .git/config .
rm -rf .git
git init
mv config .git/
git add --all .
git commit -m "update repo."
