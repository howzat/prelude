;;; package --- personal customizations
;;;
;;; Commentary:
;;; These are customizations that are specific to my
;;; prelude configured emacs setup

;;; Code:

;; set up pallet so we can track installed packages in our config
(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

;; Stuff that's only done in graphical mode
(when (display-graphic-p)
  ;; use solarized dark because it's pretty
  (load-theme 'sanityinc-solarized-dark)

  ;; change the default font to Inconsolata using the hacked version
  ;; available at
  ;; https://github.com/Lokaltog/powerline-fonts/tree/master/Inconsolata
  (set-face-attribute 'default nil
                      :family "Inconsolata for Powerline" :height 120))

;; enable CUA mode, but disable key bindings, for rectangular
;; selection using C-Enter
(cua-mode t)
(setq cua-enable-cua-keys nil)

;; delete trailing whitespace on save
(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))

;; modeline customizations
;; time display formatting
(setq display-time-day-and-date t
      display-time-24hr-format t)
(display-time-mode t)

;; reenable arrow keys (for now)
(setq prelude-guru nil)

;; don't automatically set scripts executable on save
(remove-hook 'after-save-hook
             'executable-make-buffer-file-executable-if-script-p)

;; enable company mode everywhere
(add-hook 'after-init-hook
          (lambda ()
            (global-company-mode)))
            ;; (add-hook 'python-mode-hook 'anaconda-mode)
            ;; (add-to-list 'company-backends 'company-anaconda)))

;; custom keybindings
;; override insertion of hash key because of british keyboards
;; TODO: check to see if we can detect thg keyboard layout before setting
(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))

;; much nicer window switching
;; https://github.com/dimitri/switch-window
(when (fboundp 'switch-window) (global-set-key (kbd "C-x o") 'switch-window))

;; finally start an emacs server unless one is already running
(require 'server)
(unless (server-running-p)
  (server-start))
