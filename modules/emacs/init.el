;; -*- lexical-binding:t -*-

;;colors
(setq
c-bg        "#1d2021"
c-fg        "#d5c4a1"
c-red       "#cc241d"
c-green     "#98971a"
c-yellow    "#d79921"
c-blue      "#458588"
c-magenta   "#b16286"
c-cyan      "#689d6a"
c-white     "#a89984"
c-black     "#928374"
c-red-2     "#fb4934"
c-green-2   "#b8bb26"
c-yellow-2  "#fabd2f"
c-blue-2    "#83a598"
c-magenta-2 "#d3869b"
c-cyan-2    "#8ec07c"
c-white-2   "#ebdbb2")
;;settings
(setq display-line-numbers-type 'relative)
(setq inhibit-startup-screen t)
(set-face-attribute 'default nil :font "Monoid" :height 120)
(global-hl-line-mode 1)
(scroll-bar-mode 0) (tool-bar-mode 0)
(menu-bar-mode 0)
(fringe-mode 0)
(global-display-line-numbers-mode 1)
(setq initial-major-mode 'emacs-lisp-mode)
(setq frame-resize-pixelwise t)
(setq auto-window-vscroll nil)
(setq scroll-step 1)

;;add packages and shit
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
(require 'use-package)


;;package config and modes
(use-package gruvbox-theme
  :init (load-theme 'gruvbox-dark-hard t))

(use-package ivy
  :config
  (define-key ivy-minibuffer-map (kbd "C-n") 'ivy-next-line)
  (define-key ivy-minibuffer-map (kbd "C-e") 'ivy-previous-line)
  (define-key ivy-minibuffer-map (kbd "C-i") 'ivy-done)
  (ivy-mode 1))

(use-package elcord
  :config
  (elcord-mode 1))

(use-package undo-tree
  :config
  (global-undo-tree-mode 1))

(use-package evil
  :config
  (evil-set-undo-system 'undo-tree)
  (evil-mode 1))

(use-package evil-colemak-basics
  :init
  (setq evil-colemak-basics-layout-mod 'mod-dh)
  :config
  (global-evil-colemak-basics-mode 1))

(use-package treemacs
  :config
  (treemacs-filewatch-mode 1)
  (treemacs-git-mode 'deferred))

(use-package treemacs-evil
  :config
  (define-key evil-treemacs-state-map (kbd "n")   #'treemacs-next-line)
  (define-key evil-treemacs-state-map (kbd "e")   #'treemacs-previous-line)
  (define-key evil-treemacs-state-map (kbd "M-n") #'treemacs-next-neighbour)
  (define-key evil-treemacs-state-map (kbd "M-e") #'treemacs-previous-neighbour)
  (define-key evil-treemacs-state-map (kbd "M-N") #'treemacs-next-line-other-window)
  (define-key evil-treemacs-state-map (kbd "M-E") #'treemacs-previous-line-other-window)
  (define-key evil-treemacs-state-map (kbd "M")   #'treemacs-collapse-parent-node)
  (evil-define-key 'treemacs treemacs-mode-map (kbd "m") #'treemacs-COLLAPSE-action)
  (evil-define-key 'treemacs treemacs-mode-map (kbd "i") #'treemacs-RET-action)
 )

(use-package lsp-mode
  :config
  (lsp-mode 1))

(use-package lsp-treemacs
  :config
  (lsp-treemacs-sync-mode))

(use-package lsp-ui
  :config
  (lsp-ui-peek-enable 1)
  (lsp-ui-doc-enable 1))

(use-package tree-sitter-langs)

(use-package tree-sitter
  :config
  (global-tree-sitter-mode)
  :init 
  (add-to-list 'tree-sitter-major-mode-language-alist '(fundamental-mode . bash))
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package flex-autopair
  :config
  (flex-autopair-mode 1))

(use-package rainbow-mode
  :config
  (rainbow-mode 1))

(use-package rustic)

(use-package magit)

(use-package nix-mode
  :mode "\\.nix\\'")

(defface bufname
  `((t :foreground ,c-fg
       :background ,c-bg
       :weight bold
     ))
  "Custom face for buffer name"
  :group 'mode-line-faces )

(defface majmode
  `((t :foreground ,c-fg
       :background ,c-bg
     ))
  "Custom face for major mode"
  :group 'mode-line-faces )

(defface gitmode
  `((t :foreground ,c-fg
       :background ,c-red-2
       :weight bold
     ))
  "Custom face for VC"
  :group 'mode-line-faces )
(defface infomode
  `((t :foreground ,c-bg
       :background ,c-green
       :weight bold
     ))
  "For showing line and column number"
  :group 'mode-line-faces )


(setq-default mode-line-format
              '((:propertize " %b " face bufname)
                (vc-mode (:propertize (" " vc-mode " " ) face gitmode))
                (:propertize (" " mode-name " ") face majmode)
                (:propertize ("[[ %l | %c || %p . %+%@ ]]") face infomode)
                ("%-")))

(setq exclude-ln '(term-mode-hook eshell-mode-hook shell-mode-hook))
(while exclude-ln
       (add-hook (car exclude-ln) (lambda () (display-line-numbers-mode 0)))
       (setq exclude-ln (cdr exclude-ln)))
(let ((default-color (cons (face-background 'mode-line)
                           (face-foreground 'mode-line))))
  (add-hook 'post-command-hook
       (lambda ()
         (let ((color (cond ((minibufferp) default-color)
                            ((evil-insert-state-p) (cons c-magenta c-fg))
                            ((evil-visual-state-p) (cons c-cyan    c-fg))
                            ((evil-normal-state-p) (cons c-fg      c-bg))
                            ((buffer-modified-p)   (cons c-blue    c-fg))
                            (t default-color))))
	   (set-face-background 'bufname (car color))
	   (set-face-foreground 'bufname (cdr color))
	   ))))
