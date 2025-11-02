; |--------------------|
; |  ui configuration  |
; |--------------------|

(tool-bar-mode -1) ; hide tool bar
(scroll-bar-mode -1) ; hide the scroll bar
(tooltip-mode -1) ; disable tooltips
(set-fringe-mode 10) ; add margins
(menu-bar-mode -1) ; disable the menu bar
(setq visible-bell t) ; use visual rather than audio bell
(global-visual-line-mode 1) ; wrap lines

; enabel line numbering
(global-display-line-numbers-mode t) ; enable line numbers
(setq display-line-numbers-type 'relative) ; set line numbering mode to relative

;disable line-numbering for specific modes
(dolist (mode '(eshell-mode-hook
	        term-mode-hook
		shell-mode-hook
		vterm-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

; (desktop-save-mode 1) ; save windows and frames etc

; |----------------------|
; |  startup debloating  |
; |----------------------|

(setq inhibit-startup-screen t) ; remove the welcome screen
(setq initial-scratch-message  nil) ; don't display sratch messagehow to save a 
(setq use-file-dialog nil) ; remove "are you sure you want to quit" dialog


; |-----------------------------|
; |  configure package manager  |
; |-----------------------------|

; package
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

; use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)


; |-------------------------|
; |  load/install packages  |
; |-------------------------|

; note please run all-the-icons-install-fonts via M-x once per system install to download fonts
(use-package all-the-icons)

(use-package ivy
  :bind (:map ivy-minibuffer-map
	      ("C-j" . ivy-next-line)
	      ("C-k" . ivy-previous-line)))

; fix this so the packages are loaded in manually
(ivy-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(all-the-icons company company-jedi counsel dap-mode doom-modeline
		   elpy evil flycheck helm-lsp helpful ivy ivy-rich
		   lsp-ivy lsp-mode lsp-treemacs lsp-ui magit
		   org-bullets projectile rainbow-delimiters rust-mode
		   rustic vterm-mode vterm-toggle)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file))
  :config
  (setq ivy-initial-inputs-alist nil)) ; don't start searches with ^

(use-package ivy-rich 
  :config
  (ivy-rich-mode 1)
  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line))

(use-package nerd-icons
  :config
  (setq nerd-icons-font-family "0xProto Nerd Font"))

(use-package doom-modeline
  :init (doom-modeline-mode 1))

(use-package which-key
  :init
  (setq which-key-idle-delay 1) 
  :diminish which-key-mode
  :config
  (which-key-mode))

(use-package evil
  :demand t
  :config
  (evil-mode 1))

(use-package vterm)

(use-package org-bullets
  :demand t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (councel-describe-variable-function #'helpful-variable)
  :bind (("C-h f" . #'helpful-callable)
	 ("C-h v" . #'helpful-variable)
	 ("C-h x" . #'helpful-command)
	 ("C-h k" . #'helpful-key)))

; ide/lsp packages

(use-package flycheck :ensure)

(defun custom-rust-mode-hook ()
  (setq indent-tabs-mode nil
	tab-width 4
	c-basic-offset 4
	fill-column 100))
;(use-package rust-mode
;  :hook (rust-mode . custom-rust-mode-hook))

(use-package rustic
  :hook (rustic-mode . custom-rust-mode-hook))


(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c s")
  :hook ((common-lisp-mode . lsp)
         (python-mode . lsp)
         (rust-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)
(use-package lsp-ui :commands lsp-ui-mode)
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
;(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;;(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

(use-package company
  :hook (after-init . global-company-mode)
  :init
  (setq company-minimum-prefix-length 1)
  :config
  (define-key company-active-map (kbd "C-j") #'company-select-next)
  (define-key company-active-map (kbd "C-k") #'company-select-previous))

;; (defun my/python-mode-hook ()
;;   (add-to-list 'company-backends 'company-jedi))
;; (use-package company-jedi
;;   :hook (python-mode-hook . my/python-mode-hook))
;; (add-to-list 'company-backends 'company-jedi)

(use-package elpy
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable))

(use-package projectile
  :config
  (projectile-mode 1))


; |--------------|
; |  appearence  |
; |--------------|

; theme
(load-theme 'deeper-blue t)

; add transparency
(set-frame-parameter (selected-frame) 'alpha '(95 95))
(add-to-list 'default-frame-alist '(alpha 95 95))

; |----------------------|
; |  custom keybindings  |
; |----------------------|

; make escape more effective
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

; org mode key bindings
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

;(global-set-key (kbd "C-M-j") 'counsel-switch-buffer)
 
; |--------|
; |  misc  |
; |--------|

(setq org-agenda-files '("~/org/"))
