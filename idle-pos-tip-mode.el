
(require 'help-at-pt)
(require 'pos-tip)

(defgroup idle-pos-tip nil
  "Options for `idle-pos-tip-mode`."
  :group 'tools)

(defcustom idle-pos-tip-interval 1.0
  "Number of seconds to wait before displaying"
  :type 'number
  :group 'idle-pos-tip)

(defvar idle-pos-tip-timer nil)

(defun idle-pos-tip-show ()
  (let ((text (help-at-pt-string)))
    (when text
      (pos-tip-show text))))

(defun idle-pos-tip-activate-timer ()
  (when (not idle-pos-tip-timer)
    (setq idle-pos-tip-timer
          (run-with-idle-timer idle-pos-tip-interval t
                               (lambda ()
                                 (when idle-pos-tip-mode
                                   (idle-pos-tip-show)))))))

(define-minor-mode idle-pos-tip-mode
  "Show the help text at point in a tooltip window in idle time"
  :lighter " Pos"
  :keymap '()
  :group 'idle-pos-tip
  :require 'idle-pos-tip-mode
  (when idle-pos-tip-mode
    (idle-pos-tip-activate-timer)))

(provide 'idle-pos-tip-mode)
