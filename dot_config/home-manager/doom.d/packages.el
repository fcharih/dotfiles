;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;; (package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/radian-software/straight.el#the-recipe-format
;; (package! another-package
;;   :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;; (package! this-package
;;   :recipe (:host github :repo "username/repo"
;;            :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;; (package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;; (package! builtin-package :recipe (:nonrecursive t))
;; (package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see radian-software/straight.el#279)
;; (package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;; (package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;; (unpin! pinned-package)
;; ...or multiple packages
;; (unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;; (unpin! t)
(package! websocket)

(package! typst-ts-mode
  :recipe (:host nil :repo "https://git.sr.ht/~meow_king/typst-ts-mode")
  :pin "1367003e2ad55a2f6f9e43178584683028ab56e9")            ; see note below

(package! typst-preview
  :recipe (:host github :repo "havarddj/typst-preview.el")
  :pin "f2903a1b98e13be7c927de835ae0d9159dd9fb9a")

(package! smudge
  :recipe (:host github :repo "danielfm/smudge")
  :pin "c90db830e84e34ac5724f57eda2f1112a589df5c")

(package! kitty-graphics
  :recipe (:host github :repo "cashmeredev/kitty-graphics.el")
  :pin "13666d4eb2ef4eeed24697c0326368eff3667dce")

(package! claude-code-ide
  :recipe (:host github :repo "manzaltu/claude-code-ide.el")
  :pin "32a8a904ac21e52c54231b99796d12ae36df9c22")

(package! pg
  :recipe (:host github :repo "emarsden/pg-el")
  :pin "ced3f1e4fa9bb8d3d33150f43d0dc357e4917636")

(package! pgmacs
  :recipe (:host github :repo "emarsden/pgmacs")
  :pin "72c98973e750c9a2a39780a4f43d3c9aaad8e06e")

(package! code-cells)
(package! exec-path-from-shell)
