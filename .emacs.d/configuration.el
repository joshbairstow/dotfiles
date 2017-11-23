
(load-file "~/git/sensible-defaults.el/sensible-defaults.el")
(sensible-defaults/use-all-settings)
(sensible-defaults/use-all-keybindings)
(sensible-defaults/backup-to-temp-directory)

(add-to-list 'load-path "~/git/evil")
(require 'evil)
(evil-mode 1)

(add-to-list 'load-path "~/git/evil-adjust")
(require 'evil-adjust)
(evil-adjust)

;;  (global-evil-surround-mode 1)

(define-key evil-normal-state-map (kbd "C-p") 'projectile-find-file)

(tool-bar-mode 0)
(menu-bar-mode 0)
(when window-system
  (scroll-bar-mode -1))

(setq frame-title-format '((:eval (projectile-project-name))))

(global-prettify-symbols-mode t)

(when window-system
  (global-hl-line-mode))

(setq-default tab-width 2)

(custom-set-variables
;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
'(ansi-color-faces-vector
[default default default italic underline success warning error])
'(ansi-color-names-vector
["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
'(custom-enabled-themes (quote (tsdh-dark))))
(custom-set-faces
;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
)

(setq scheme-root "Applications/MIT-Scheme.app/Contents/Resources")

;; (setq scheme-program-name
;;       (concat
;;        scheme-root "/mit-scheme "
;;        "--library " scheme-root " "
;;        "--band " scheme-root "/all.com "
;;        "-heap 10000"))

(setq scheme-program-name "/Applications/MIT-Scheme.app/Contents/Resources/mit-scheme")

(add-to-list 'load-path "~/git/rainbow-delimiters")
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;;; I prefer cmd key for meta
(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)
(set-keyboard-coding-system nil)

;;; Enable Ido mode by default
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-create-new-buffer 'always)
(ido-mode 1)
