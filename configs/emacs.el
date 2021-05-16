;;definitions
(defun install (a) (unless (package-installed-p a) (package-install a)))


;;settings
(global-display-line-numbers-mode 0)
(setq display-line-numbers-type 'relative)
(setq inhibit-startup-screen t)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)
;;(fringe-mode 0)
(set-face-attribute 'default nil :font "Fira Mono for Powerline" :height 120)
;;(set-face-background 'line-number-current-line nil :background t)


;;packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(install 'use-package)
(setq use-package-always-ensure t)
(require 'use-package)

;;install shit
(use-package elcord
  :config
  (elcord-mode 1))
(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox-dark-hard t))
(use-package ivy
  :bind (:map ivy-minibuffer-map
	      ("C-n" . ivy-next-line)
	      ("C-e" . ivy-previous-line)
	      ("C-i" . ivy-done))
  :config
  (ivy-mode 1))

;;keybinds
;;ivy
;(define-key ivy-minibuffer-map (kbd "C-n") 'ivy-next-line)
;(define-key ivy-minibuffer-map (kbd "C-e") 'ivy-previous-line)
;(define-key ivy-minibuffer-map (kbd "C-i") 'ivy-done)
