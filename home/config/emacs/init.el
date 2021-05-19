;;settings
(setq display-line-numbers-type 'relative)
(setq inhibit-startup-screen t)
(set-face-attribute 'default nil :font "Fira Mono for Powerline" :height 120)



;;add packages and shit
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
(setq pkgs '(ivy gruvbox-theme elcord rainbow-delimiters))
(while pkgs
       (require (car pkgs))
       (setq pkgs (cdr pkgs)))


;;package config and modes
(global-hl-line-mode 1)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)
(fringe-mode 0)
(global-display-line-numbers-mode 1)
(load-theme 'gruvbox-dark-hard t)
(ivy-mode 1)
(elcord-mode 1)


;;keybinds
;ivy
(define-key ivy-minibuffer-map (kbd "C-n") 'ivy-next-line)
(define-key ivy-minibuffer-map (kbd "C-e") 'ivy-previous-line)
(define-key ivy-minibuffer-map (kbd "C-i") 'ivy-done)


;;hooks
;exclude line numbers
(setq exclude-ln '(term-mode-hook eshell-mode-hook shell-mode-hook))
(while exclude-ln
       (add-hook (car exclude-ln) (lambda () (display-line-numbers-mode 0)))
       (setq exclude-ln (cdr exclude-ln)))

;rainbow delims
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
