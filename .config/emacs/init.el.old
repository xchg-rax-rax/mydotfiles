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
(set-face-attribute 'default nil :font "JetBrainsMonoNL Nerd Font" :height 125) ; Use nerd fonts
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

;; Line numbering with nlinum
(use-package nlinum)
(use-package nlinum-relative)
(global-nlinum-mode t)
(nlinum-relative-setup-evil)
(add-hook 'prog-mode-hook 'nlinum-relative-mode)

;; Simpleclip to manage the clipboard
(use-package simpleclip)
(simpleclip-mode 1)

;; Powerline for emacs
(require 'powerline)
(powerline-default-theme)

;; LSP packages
(use-package lsp-mode :commands lsp)
(use-package lsp-ui :commands lsp-ui-mode)

;; Comapny for autocomplete
(use-package company)
(add-hook 'after-init-hook 'global-company-mode)

;; ccls for C/C++/ObjC language support
(use-package ccls
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
         (lambda () (require 'ccls) (lsp))))
(setq ccls-executable "/bin/ccls")
(setq ccls-initialization-options '(:index (:comments 2) :completion (:detailedLabel t)))

;; Python linting and LSP packages
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))
(use-package python-black
  :demand t
  :after python
  :hook (python-mode . python-black-on-save-mode-enable-dwim))

;; Hy language mode for emacs
(use-package hy-mode)

;; PHP Language Mode for when you're finding bugs (or writing them)
(use-package php-mode)
(defun my-php-mode-init ()
  (subword-mode 1)
  (setq-local show-trailing-whitespace t)
  (setq-local ac-disable-faces '(font-lock-comment-face font-lock-string-face))
  (add-hook 'hack-local-variables-hook 'php-ide-turn-on nil t))

(with-eval-after-load 'php-mode
  (add-hook 'php-mode-hook #'my-php-mode-init)
  (custom-set-variables
   '(php-mode-coding-style 'psr2)
   '(php-mode-template-compatibility nil)
   '(php-imenu-generic-expression 'php-imenu-generic-expression-simple)))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(nlinum-relative nlinum vterm python-black lsp-pyright php-mode simpleclip powerline lsp-ui ivy hy-mode evil company command-log-mode ccls))
 '(php-imenu-generic-expression 'php-imenu-generic-expression-simple)
 '(php-mode-coding-style 'psr2)
 '(php-mode-template-compatibility nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
