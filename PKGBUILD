# Maintainer: Your Name <your.email@example.com>
pkgname=aardwolf-ttmux-git
pkgver=20260506.976c1f0
pkgrel=1
pkgdesc="A TUI client for the Aardwolf MUD based on tintin and tmux"
arch=('any')
url="https://github.com/theixle/aardwolf-tintin"
license=('unknown')
depends=('tintin' 'tmux' 'coreutils')
optdepends=('perl-dbi: for mush-map-to-tintin-converter'
            'perl-dbd-sqlite: for mush-map-to-tintin-converter')
makedepends=('git')
provides=('aardwolf-ttmux')
conflicts=('aardwolf-ttmux')
source=('aardwolf-ttmux::git+https://github.com/theixle/aardwolf-tintin.git'
        'aardwolf-ttmux.sh')
sha256sums=('SKIP'
            '9e8580f3e646808808fdd7d4b6fd13f0a74f0960d5d14e80c61fe29f0af6f86b')

pkgver() {
  cd "$srcdir/aardwolf-ttmux"
  git describe --always --tags | sed 's/-/./g'
}

package() {
  cd "$srcdir/aardwolf-ttmux"
  
  install -dm755 "$pkgdir/usr/share/aardwolf-ttmux"
  cp -r modules conf util bin setup.tin README README.MD "$pkgdir/usr/share/aardwolf-ttmux/"
  
  install -Dm755 "$srcdir/aardwolf-ttmux.sh" "$pkgdir/usr/bin/aardwolf-ttmux"
  
  install -Dm644 README.MD "$pkgdir/usr/share/licenses/$pkgname/LICENSE.MD"
  install -Dm644 README.MD "$pkgdir/usr/share/doc/$pkgname/README.MD"
}
