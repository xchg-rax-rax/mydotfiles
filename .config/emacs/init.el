;; My (second?) emacs config 

;; Debloating Defaults
(setq inhibit-startup-message t)

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)

(set-fringe-mode 10) ; Adds some padding to the margins

(setq visible-bell t) ; Use visual bell rather than beeping

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Appearance
(set-face-attribute 'default nil :font "JetBrainsMonoNL Nerd Font") ; Use nerd fonts
(load-theme 'tango-dark)

;; Package Management with MELPA

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)
(setq use-package-always-ensure t) ; Make sure all packages are download on load

;; Ivy for autocompletion 
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

;; Evil for sweet sweet vim keybindings etc
(use-package evil)
(evil-mode 1)

;; LSP packages
(use-package lsp-mode :commands lsp)
(use-package lsp-ui :commands lsp-ui-mode)

;; ccls for C/C++/ObjC language support
(use-package simpleclip)
(simpleclip-mode 1)

(use-package ccls
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
         (lambda () (require 'ccls) (lsp))))
(setq ccls-executable "/bin/ccls")
(setq ccls-initialization-options '(:index (:comments 2) :completion (:detailedLabel t)))
