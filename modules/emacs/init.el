;;settings
(setq display-line-numbers-type 'relative)
(setq inhibit-startup-screen t)
(set-face-attribute 'default nil :font "Monoid" :height 120)
(global-hl-line-mode 1)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)
(fringe-mode 0)
(global-display-line-numbers-mode 1)
(setq initial-major-mode 'emacs-lisp-mode)

;;add packages and shit
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
(require 'use-package)


;;package config and modes
(use-package gruvbox-theme
  :init
  (load-theme 'gruvbox-dark-hard t))

(use-package ivy
  :config
  (ivy-mode 1))

(use-package elcord
  :config
  (elcord-mode 1))

(use-package evil
  :config
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
  :bind (:map evil-treemacs-state-map
              ("n" . treemacs-next-line)
              ("e" . treemacs-previous-line)
              ("M-n" . treemacs-next-neighbour)
              ("M-e" . treemacs-previous-neighbour)
              ("M-N" . treemacs-next-line-other-window)
              ("M-E" . treemacs-previous-line-other-window)
              ("M" . treemacs-collapse-parent-node))
  :init

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

;(use-package rustic)

;;keybinds
;ivy
(define-key ivy-minibuffer-map (kbd "C-n") 'ivy-next-line)
(define-key ivy-minibuffer-map (kbd "C-e") 'ivy-previous-line)
(define-key ivy-minibuffer-map (kbd "C-i") 'ivy-done)

;evil-treemacs
(evil-define-key 'treemacs treemacs-mode-map (kbd "m") #'treemacs-COLLAPSE-action)
(evil-define-key 'treemacs treemacs-mode-map (kbd "i") #'treemacs-RET-action))

;;hooks
;exclude line numbers
(setq exclude-ln '(term-mode-hook eshell-mode-hook shell-mode-hook))
(while exclude-ln
       (add-hook (car exclude-ln) (lambda () (display-line-numbers-mode 0)))
       (setq exclude-ln (cdr exclude-ln)))
