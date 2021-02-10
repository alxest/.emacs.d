(provide 'alxest-coq)

(defconst VELLVM "/opt/devel/youngju.song/youngju.song/simplberry-compile/lib/vellvm/src/Vellvm")
(defconst SIMPLBERRY "/opt/devel/youngju.song/youngju.song/simplberry-compile/coq/")

(defun my-gcd ()
  (interactive)
  (let ((name (if (region-active-p)
                  (buffer-substring (region-beginning) (region-end))
                (progn
                  (push-mark)
                  (thing-at-point 'symbol)))))
    (progn (print (let ((default-directory VELLVM))
                    (shell-command-to-string (format "ag \"%s\"" name)
                                             ;; "echo $PWD"
                                             )))
           (print (let ((default-directory SIMPLBERRY))
                    (shell-command-to-string (format "ag \"%s\"" name)
                                             ;; "echo $PWD"
                                             ))))
    )
  )

(eval-after-load "coq"
    '(define-key coq-mode-map (kbd "C-c e") 'my-gcd))

(defun my-gcd (name)
  "Get Coq Definitions"
  (interactive (list (read-string "name: "
                                  (if (region-active-p)
                                      (buffer-substring (region-beginning) (region-end))
                                    (progn
                                      (push-mark)
                                      (thing-at-point 'symbol))))))
  (progn (print (let ((default-directory VELLVM))
                  (shell-command-to-string (format "ag %s" name)
                   ;; "echo $PWD"
                                           )))
         (print (let ((default-directory SIMPLBERRY))
                  (shell-command-to-string (format "ag %s" name)
                   ;; "echo $PWD"
                                           ))))

  ;; (progn (print (eshell-command (format "ag %s %s" name VELLVM)))
  ;;        (print (eshell-command (format "ag %s %s" name SIMPLBERRY))))
  )

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
;(add-hook 'coq-mode-hook '(lambda () (progn (print "ABCD") (setq undo-tree-mode 1)))) <--------- THIS DOES NOT WORK!!!!
(add-hook 'coq-mode-hook '(lambda () (undo-tree-mode 1)))
(eval-after-load "coq" '(setq undo-tree-mode 1))
(add-hook 'coq-mode-hook '(lambda () (setq holes-mode nil)))
(eval-after-load "coq"
		'(define-key coq-mode-map (kbd "C-c C-;") 'comment-or-uncomment-region))
(eval-after-load "coq"
    '(define-key coq-mode-map (kbd "C-c C-r") 'revert-buffer))
(eval-after-load "coq"
    '(define-key coq-mode-map (kbd "C-c C-z") 'alxest-eshell/new))
(eval-after-load "coq"
    '(define-key coq-mode-map (kbd "C-p") 'coq-Print))
(eval-after-load "coq"
    '(define-key coq-mode-map (kbd "C-a") 'coq-Search))
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
(eval-after-load "coq"
    '(define-key coq-mode-map (kbd "C-e") 'coq-Check))

;; (global-set-key "\C-l" 'coq-LocateConstant)
;; (global-set-key "\C-q" 'pg-insert-last-output-as-comment)
;; (global-set-key "\C-n" 'coq-LocateNotation)

(eval-after-load "coq"
    '(define-key coq-goals-mode-map (kbd "C-p") 'coq-Print))
(eval-after-load "coq"
    '(define-key coq-goals-mode-map (kbd "C-a") 'coq-Search))
(eval-after-load "coq"
    '(define-key coq-goals-mode-map (kbd "C-b") 'coq-About))
(eval-after-load "coq"
    '(define-key coq-goals-mode-map (kbd "C-k") 'proof-undo-last-successful-command))
(eval-after-load "coq"
    '(define-key coq-goals-mode-map (kbd "C-j") 'proof-assert-next-command-interactive))
(eval-after-load "coq"
    '(define-key coq-goals-mode-map (kbd "C-l") 'coq-LocateConstant))
(eval-after-load "coq"
    '(define-key coq-goals-mode-map (kbd "C-n") 'coq-LocateNotation))

(eval-after-load "coq"
    '(define-key coq-response-mode-map (kbd "C-p") 'coq-Print))
(eval-after-load "coq"
    '(define-key coq-response-mode-map (kbd "C-a") 'coq-Search))
(eval-after-load "coq"
    '(define-key coq-response-mode-map (kbd "C-b") 'coq-About))
(eval-after-load "coq"
    '(define-key coq-response-mode-map (kbd "C-k") 'proof-undo-last-successful-command))
(eval-after-load "coq"
    '(define-key coq-response-mode-map (kbd "C-j") 'proof-assert-next-command-interactive))
(eval-after-load "coq"
    '(define-key coq-response-mode-map (kbd "C-l") 'coq-LocateConstant))
(eval-after-load "coq"
    '(define-key coq-response-mode-map (kbd "C-n") 'coq-LocateNotation))

;; coq-response-mode-map
;; coq-goals-mode-map

;; (load-file "~/.emacs.d/elpa/ProofGeneral/generic/proof-site.el")
(load "~/.emacs.d/lisp/PG/generic/proof-site")
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


(global-set-key (kbd "C-S-t") nil)
(defun alxest/coq-PrintLtac ()
  (interactive)
  (coq-ask-do "Print Ltac" "Print Ltac" nil))
(eval-after-load "coq"
    '(define-key coq-mode-map (kbd "C-S-t") 'alxest/coq-PrintLtac))


; needed for Set Ltac Debug.
(add-hook 'coq-shell-mode-hook
          (lambda () (progn (print "A") (define-key evil-insert-state-map (kbd "<RET>") 'nil))))

;; Remove all annoying modes from auto mode lists

;; http://stackoverflow.com/questions/9625109/how-to-disable-verilog-mode-in-emacs
(defun replace-alist-mode (alist oldmode newmode)
  (dolist (aitem alist)
    (if (eq (cdr aitem) oldmode)
    (setcdr aitem newmode))))

;; not sure what mode you want here. You could default to 'fundamental-mode
(replace-alist-mode auto-mode-alist 'verilog-mode 'proof-general-mode)



;; (add-hook 'coq-mode-hook 'coq-commenter-mode)
;; (add-hook 'coq-commenter-mode-hook
;;           (lambda () (define-key coq-commenter-mode-map
;;                        (kbd "C-;")
;;                        #'coq-commenter-comment-proof-in-region)))
;; (add-hook 'coq-commenter-mode-hook
;;           (lambda () (define-key coq-commenter-mode-map
;;                        (kbd "C-'")
;;                        #'coq-commenter-uncomment-proof-in-region)))
