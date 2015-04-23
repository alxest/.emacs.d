(provide 'alxest-coq)


;; Grep Coq Definitions
(defun grep-coq-def (name directory)
  "Get Coq Definitions"
  (interactive (list (read-string "name: "
                                  (if (region-active-p)
                                      (buffer-substring (region-beginning) (region-end))
                                    (progn
                                      (push-mark)
                                      (thing-at-point 'symbol))))
                     (read-directory-name "directory: ")))
  (eshell-command
   (format "egrep -r --include=*.v '(Lemma|Definition|Fixpoint|Theorem|Inductive|CoInductive|Context|Module|Record|Structure|with|\\||Module Type) %s' %s"
           name directory))
  )
(defalias 'gcd 'grep-coq-def)

(eval-after-load "coq"
    '(define-key coq-mode-map (kbd "C-c C-h") 'proof-undo-last-successful-command))
(eval-after-load "coq-goal"
    '(define-key coq-mode-map (kbd "C-c C-h") 'proof-undo-last-successful-command))
(add-hook 'coq-mode-hook '(lambda () (setq undo-tree-mode t)))
(eval-after-load "coq"
		'(define-key coq-mode-map (kbd "C-c C-;") 'comment-or-uncomment-region))

(load-file "~/.emacs.d/elpa/ProofGeneral/generic/proof-site.el")
;(setq-default proof-three-window-enable t)
;(require 'coq)
;(setq coq-load-path (list "/home/youngju.song/compcert-2.4/lib"))

;; (eval-after-load "coq"
;;     '(define-key coq-mode-map (kbd "C-c C-u") 'proof-ctxt))


 ;; (require-package 'company-coq)
 ;; (add-hook 'coq-mode-hook #'company-coq-initialize)

