; -*- lexical-binding: t; -*-
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
(set-face-attribute 'default nil :font "Monoid" :height 120)
(global-hl-line-mode 1)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)
(fringe-mode 0)
(cua-mode 1)
(global-display-line-numbers-mode 1)
(setq initial-major-mode 'emacs-lisp-mode
      frame-resize-pixelwise t
      auto-window-vscroll nil
      scroll-step 1
      display-line-numbers-type 'relative
      confirm-kill-processes nil
      inhibit-startup-screen t)
(add-hook 'emacs-startup-hook
          (lambda () (delete-other-windows)) t)


;;add packages and shit
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
(require 'use-package)

;;package config and modes
;(use-package gruvbox-theme
;  :init (load-theme 'gruvbox-dark-hard t))


(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t   
        doom-themes-enable-italic t
        doom-themes-treemacs-theme "doom-colors"
        doom-gruvbox-dark-variant "hard")
  (load-theme 'doom-gruvbox t)
  (doom-themes-visual-bell-config)
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

(use-package ivy
  :config
  (define-key ivy-minibuffer-map (kbd "C-n") 'ivy-next-line)
  (define-key ivy-minibuffer-map (kbd "C-e") 'ivy-previous-line)
  (define-key ivy-minibuffer-map (kbd "C-i") 'ivy-done)
  (ivy-mode 1))

(use-package elcord
  :defer 0
  :config
  (elcord-mode 1))

(use-package undo-tree
  :config
  (global-undo-tree-mode 1))

(use-package evil
  :config
  (evil-set-initial-state 'vterm-mode 'insert)
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
  (treemacs-display-current-project-exclusively)
  (treemacs-git-mode 'deferred))

(use-package treemacs-evil :config
  (define-key evil-treemacs-state-map (kbd "n")   #'treemacs-next-line)
  (define-key evil-treemacs-state-map (kbd "e")   #'treemacs-previous-line)
  (define-key evil-treemacs-state-map (kbd "M-n") #'treemacs-next-neighbour)
  (define-key evil-treemacs-state-map (kbd "M-e") #'treemacs-previous-neighbour)
  (define-key evil-treemacs-state-map (kbd "M-N") #'treemacs-next-line-other-window)
  (define-key evil-treemacs-state-map (kbd "M-E") #'treemacs-previous-line-other-window)
;  (define-key evil-treemacs-state-map (kbd "M")   #'treemacs-collapse-parent-node)
  (evil-define-key 'treemacs treemacs-mode-map (kbd "m") #'treemacs-COLLAPSE-action)
  (evil-define-key 'treemacs treemacs-mode-map (kbd "i") #'treemacs-RET-action)
 )

(use-package lsp-mode
  :defer 0
  :init
  (setq )
  :config
  (lsp-mode 1))

(use-package lsp-treemacs
  :defer 0
  :config
  (lsp-treemacs-sync-mode 1))

(use-package lsp-ui
  :defer 0
  :init
  (setq lsp-ui-doc-show-with-cursor t)
  :config
  (lsp-ui-peek-enable 1)
  (lsp-ui-doc-enable 1))

(use-package company
  :defer 0
  :after lsp-mode
  :config
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-e") 'company-select-previous)
  (define-key company-search-map (kbd "C-n") 'company-select-next)
  (define-key company-search-map (kbd "C-e") 'company-select-previous))

(use-package company-quickhelp
  :hook (company-mode . company-quickhelp-mode))

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

(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

(use-package magit)

(use-package nix-mode
  :mode "\\.nix\\'")

(use-package projectile)

(use-package vterm
  :config
  (setq vterm-timer-delay 0.005)
  )

(use-package all-the-icons)

(use-package centaur-tabs
  :config
  (setq centaur-tabs-style "bar"
        centaur-tabs-set-bar 'left
        centaur-tabs-height 18
        centaur-tabs-set-modified-marker t
        centaur-tabs-set-icons t)
  (centaur-tabs-group-buffer-groups)
  (centaur-tabs-mode 1)
  (centaur-tabs-headline-match)
  (set-face-attribute 'tab-line nil :background c-bg :foreground c-fg)
  (set-face-attribute 'centaur-tabs-active-bar-face nil :background c-red-2)
  (set-face-attribute 'centaur-tabs-modified-marker-selected nil :foreground c-red-2)
  (set-face-attribute 'centaur-tabs-modified-marker-unselected nil :foreground c-red-2)
  (set-face-attribute 'centaur-tabs-selected nil :background c-fg :foreground c-bg)
  (set-face-attribute 'centaur-tabs-unselected nil :background c-bg :foreground c-fg)
  (set-face-attribute 'centaur-tabs-selected-modified nil :background c-fg :foreground c-bg)
  (set-face-attribute 'centaur-tabs-unselected-modified nil :background c-bg :foreground c-fg))

(use-package general)

 (use-package vterm-toggle 
   :config
   (setq vterm-toggle-fullscreen-p nil)
   (add-to-list 'display-buffer-alist
                '((lambda(bufname _) (with-current-buffer bufname (equal major-mode 'vterm-mode)))
                  (display-buffer-reuse-window display-buffer-at-bottom)
                  (reusable-frames . visible)
                  (window-height . 0.4)))
   (define-key vterm-mode-map (kbd "<f2>")   'vterm-toggle-forward)
   (define-key vterm-mode-map (kbd "<f3>")   'vterm-toggle-backward))

(use-package org)

 (use-package org-bullets
    :config
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))


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

;;keybinds
;(global-set-key (kbd "M-o") 'treemacs)
;(global-set-key (kbd "M-v") 'split-window-vertically)
;(global-set-key (kbd "M-h") 'split-window-horizontally)
;(global-set-key (kbd "M-C-m") 'shrink-window-horizontally)
;(global-set-key (kbd "M-C-i") 'enlarge-window-horizontally)
;(global-set-key (kbd "M-C-e") 'shrink-window)
;(global-set-key (kbd "M-C-n") 'enlarge-window)
;(global-set-key (kbd "C-S-m")  'windmove-left)
;(global-set-key (kbd "C-S-i") 'windmove-right)
;(global-set-key (kbd "C-S-e")  'windmove-up)
;(global-set-key (kbd "C-S-n")  'windmove-down)
;(global-set-key (kbd "M->")  'previous-buffer)
;(global-set-key (kbd "M-<")  'next-buffer)
;(global-set-key (kbd "M-C-S-q")  'kill-buffer)


;; stolen from https://www.reddit.com/r/emacs/comments/ft84xy/run_shell_command_in_new_vterm/
(defun run-in-vterm-kill (process event)
  "A process sentinel. Kills PROCESS's buffer if it is live."
  (let ((b (process-buffer process)))
    (and (buffer-live-p b)
         (kill-buffer b))))

(defun run-in-vterm (command)
  (interactive
   (list
    (let* ((f (cond (buffer-file-name)
                    ((eq major-mode 'dired-mode)
                     (dired-get-filename nil t))))
           (filename (concat " " (shell-quote-argument (and f (file-relative-name f))))))
      (read-shell-command "Terminal command: "
                          (cons filename 0)
                          (cons 'shell-command-history 1)
                          (list filename)))))
  (with-current-buffer (vterm-toggle)
    (set-process-sentinel vterm--process #'run-in-vterm-kill)
    (vterm-send-string (concat command))
    (vterm-send-return)))

(defun candrun ()
  (let ((full buffer-file-name)
        (file (file-name-sans-extension buffer-file-name)))
    (pcase (file-name-extension full)
           ("c" (concat "gcc " full " -o " file " && " file " && rm " file))
           ("java" (concat "java" full))
           ("py" (concat "python" full))
           ("cpp" (concat "g++ " full " -o " file " && " file " && rm " file))
           ("hs" (concat "ghc -dynamic" full " && " file " && rm " file " " file ".o"))
           ("sh" (concat "sh" full))
           ("bash" (concat "bash" full))
           ("zsh" (concat "zsh" full))
           ("js" (concat "node" full))
           ("ts" (concat "tsc" full " && node " file ".js && rm " file ".js" ))
           ("rs" (concat "rustc" full " -o " file " && " file " && rm " file)))))

(general-define-key
  :states '(normal emacs visual motion treemacs Eshell override)
  "M-o" 'treemacs
  "M-v" 'split-window-vertically
  "M-h" 'split-window-horizontally
  "M-C-m" 'shrink-window-horizontally
  "M-C-i" 'enlarge-window-horizontally
  "M-C-e" 'shrink-window
  "M-C-n" 'enlarge-window
  "C-m" 'windmove-left
  "C-i" 'windmove-right
  "C-n" 'windmove-down
  "C-e" 'windmove-up
  "M-,"  'previous-buffer
  "M-."  'next-buffer
  "M-C-S-q"  'kill-buffer-and-window
  "M-w"  'centaur-tabs--kill-this-buffer-dont-ask
  "M-S-w"  'kill-window
  "M-S-," 'centaur-tabs-backward
  "M-S-." 'centaur-tabs-forward)

(general-define-key
  :states '(override insert normal visual treemacs motion)
  "M-f" 'lsp-format-buffer
  "<f4>"  (lambda () (interactive) (vterm t))
  "C-<f1>" 'vterm-toggle-cd
  "<f1>" 'vterm-toggle
  "<f5>" (lambda () (interactive) (run-in-vterm (candrun))))


(general-define-key
  :states '(normal insert)
  :keymaps 'VTerm
  "C-S-v" 'vterm-yank
  )


