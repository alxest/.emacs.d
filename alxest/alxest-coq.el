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
;; (eval-after-load "coq-goal"
;;     '(define-key coq-mode-map (kbd "C-c C-h") 'proof-undo-last-successful-command))
(add-hook 'coq-mode-hook '(lambda () (setq undo-tree-mode t)))
(eval-after-load "coq"
		'(define-key coq-mode-map (kbd "C-c C-;") 'comment-or-uncomment-region))
(eval-after-load "coq"
    '(define-key coq-mode-map (kbd "C-c C-r") 'revert-buffer))
(eval-after-load "coq"
    '(define-key coq-mode-map (kbd "C-c C-z") 'alxest-eshell/new))
(eval-after-load "coq"
    '(define-key coq-mode-map (kbd "C-p") 'coq-Print))
(eval-after-load "coq"
    '(define-key coq-mode-map (kbd "C-a") 'coq-SearchAbout))
(eval-after-load "coq"
    '(define-key coq-mode-map (kbd "C-b") 'coq-About))
;; (eval-after-load "coq"
;;     '(define-key coq-mode-map (kbd "C-n") 'coq-LocateNotation))
(eval-after-load "coq"
    '(define-key coq-mode-map (kbd "C-k") 'proof-undo-last-successful-command))
(eval-after-load "coq"
    '(define-key coq-mode-map (kbd "C-j") 'proof-assert-next-command-interactive))

(eval-after-load "coq"
    '(define-key coq-mode-map (kbd "C-l") 'coq-LocateConstant))
(eval-after-load "coq"
    '(define-key coq-mode-map (kbd "C-q") 'pg-insert-last-output-as-comment))
(eval-after-load "coq"
    '(define-key coq-mode-map (kbd "C-n") 'coq-LocateNotation))

;; (global-set-key "\C-l" 'coq-LocateConstant)
;; (global-set-key "\C-q" 'pg-insert-last-output-as-comment)
;; (global-set-key "\C-n" 'coq-LocateNotation)

(eval-after-load "coq"
    '(define-key coq-goals-mode-map (kbd "C-p") 'coq-Print))
(eval-after-load "coq"
    '(define-key coq-response-mode-map (kbd "C-p") 'coq-Print))

;; coq-response-mode-map
;; coq-goals-mode-map

(load-file "~/.emacs.d/elpa/ProofGeneral/generic/proof-site.el")
;(setq-default proof-three-window-enable t)
;(require 'coq)
;(setq coq-load-path (list "/home/youngju.song/compcert-2.4/lib"))

;; (eval-after-load "coq"
;;     '(define-key coq-mode-map (kbd "C-c C-u") 'proof-ctxt))


 ;; (require-package 'company-coq)
 ;; (add-hook 'coq-mode-hook #'company-coq-initialize)

;proof-general specific
;; (define-key key-translation-map (kbd "cn") (kbd "C-c C-n"))
;; (define-key key-translation-map (kbd "ch") (kbd "C-c C-h"))
;; (define-key key-translation-map (kbd "c RET") (kbd "C-c C-<return>"))
;(define-key evil-normal-state-map (kbd "ch") 'proof-undo-last-successful-command)
;(define-key evil-normal-state-map (kbd "cn") 'proof-assert-next-command-interactive)
(define-key evil-normal-state-map (kbd "c RET") 'proof-goto-point)

