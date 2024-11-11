;;; init.el --- Spacemacs Initialization File -*- no-byte-compile: t -*-
;;
;; Copyright (c) 2012-2024 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.


;; Without this comment emacs25 adds (package-initialize) here
;; (package-initialize)

;; Avoid garbage collection during startup.
;; see `SPC h . dotspacemacs-gc-cons' for more info

(defconst emacs-start-time (current-time))
(setq gc-cons-threshold 402653184 gc-cons-percentage 0.6)
(load (concat (file-name-directory load-file-name) "core/core-load-paths")
      nil (not init-file-debug))
(load (concat spacemacs-core-directory "core-versions")
      nil (not init-file-debug))
(load (concat spacemacs-core-directory "core-dumper")
      nil (not init-file-debug))

;; Remove compiled core files if they become stale or Emacs version has changed.
(load (concat spacemacs-core-directory "core-compilation")
      nil (not init-file-debug))
(load spacemacs--last-emacs-version-file t (not init-file-debug))
(when (or (not (string= spacemacs--last-emacs-version emacs-version))
          (> 0 (spacemacs//dir-byte-compile-state
                (concat spacemacs-core-directory "libs/"))))
  (spacemacs//remove-byte-compiled-files-in-dir spacemacs-core-directory))
;; Update saved Emacs version.
(unless (string= spacemacs--last-emacs-version emacs-version)
  (spacemacs//update-last-emacs-version))

(if (not (version<= spacemacs-emacs-min-version emacs-version))
    (error (concat "Your version of Emacs (%s) is too old. "
                   "Spacemacs requires Emacs version %s or above.")
           emacs-version spacemacs-emacs-min-version)
  ;; Disabling file-name-handlers for a speed boost during init might seem like
  ;; a good idea but it causes issues like
  ;; https://github.com/syl20bnr/spacemacs/issues/11585 "Symbol's value as
  ;; variable is void: \213" when emacs is not built having:
  ;; `--without-compress-install`
  (let ((please-do-not-disable-file-name-handler-alist nil))
    (require 'core-spacemacs)
    (spacemacs/dump-restore-load-path)
    (configuration-layer/load-lock-file)
    (spacemacs/init)
    (configuration-layer/stable-elpa-init)
    (configuration-layer/load)
    (spacemacs-buffer/display-startup-note)
    (spacemacs/setup-startup-hook)
    (spacemacs/dump-eval-delayed-functions)
    (when (and dotspacemacs-enable-server (not (spacemacs-is-dumping-p)))
      (require 'server)
      (when dotspacemacs-server-socket-dir
        (setq server-socket-dir dotspacemacs-server-socket-dir))
      (unless (server-running-p)
        (message "Starting a server...")
        (server-start)))))

;; Org-mode customization
(setq org-hide-leading-stars t)
(setq org-superstar-leading-bullet nil)
(setq org-startup-indented t)
(setq org-startup-folded t)
(spaceline-toggle-org-clock-on)

;; Define todo states
(setq org-todo-keywords
      '((sequence "TODO(t)" "DOING(d)" "PAUSED(p)" "SCHEDULED(s)" "REJECTED(r)" "DONE(D)")))

;; Set todo keyword colors
(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "orange" :weight bold)
              ("DOING" :foreground "magenta" :weight bold)
              ("PAUSED" :foreground "violet" :weight bold)
              ("SCHEDULED" :foreground "yellow" :weight bold)
              ("REJECTED" :foreground "red" :weight bold)
              ("DONE" :foreground "green" :weight bold))))

;; Org-todo automatically change to done when all children are done
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-todo-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook #'org-summary-todo)

;; Load org agenda files
(load-library "find-lisp")
(add-hook 'org-agenda-mode-hook (lambda ()
  (setq org-agenda-files
    (find-lisp-find-files "~/workspace/diary" "\.org$"))))

;; Set default launch terminal to iterm
(setq terminal-here-mac-terminal-command 'iterm2)

;; Treemacs resize icons
(treemacs-resize-icons 12)

;; Spacemacs transparency
(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))

(add-hook 'window-setup-hook 'on-after-init)

;; Add org-mode priorities
(setq org-highest-priority ?A
      org-default-priority ?B
      org-lowest-priority ?D)

;; Set org-mode priority colors
(setq org-priority-faces '((?A . (:foreground "green"))
                           (?B . (:foreground "magenta"))
                           (?C . (:foreground "orange"))
                           (?D . (:foreground "yellow"))))

;; Set counsel default search engine to google
(setq counsel-search-engine 'google)

;; Disable ivy counsel fuzzy search
(setq ivy-initial-inputs-alist nil)

;; Load OrgModeClockingXBar
(load-file "/Users/mtoppo/.emacs.d/workspace/OrgModeClockingXBar/OrgModeClockingXBar.el")
