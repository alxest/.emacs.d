(provide 'alxest-unicode)
;; Input of unicode symbols
(require 'math-symbol-lists)
; Automatically use math input method for Coq files
(add-hook 'coq-mode-hook (lambda () (set-input-method "math")))
; Input method for the minibuffer
(defun my-inherit-input-method ()
  "Inherit input method from `minibuffer-selected-window'."
  (let* ((win (minibuffer-selected-window))
         (buf (and win (window-buffer win))))
    (when buf
      (activate-input-method (buffer-local-value 'current-input-method buf)))))
(add-hook 'minibuffer-setup-hook #'my-inherit-input-method)
; Define the actual input method
(quail-define-package "math" "UTF-8" "Ω" t)
(quail-define-rules ; add whatever extra rules you want to define here...
 ("\\!"   ?ǃ)
 ("\\u"   ?↑)
 ("\\d"   ?↓)
 ("\\s"   ?Σ)
 ("\\e"   ?ε) ;ϵ
 ("\\aa"  ?●)
 ("\\af"  ?◯)
 ("\\+"   ?⋅)
 ;; ("\\ent"    ?⊢)
 ;; ("\\valid"  ?✓)
 ;; ("\\box"    ?□)
 ;; ("\\later"  ?▷)
 ;; ("\\pred"   ?φ)
 ("\\a"    ?∧)
 ("\\o"     ?∨)
 ;; ("\\comp"   ?∘)
 ;; ("\\ccomp"  ?◎)
 ;; ("\\all"    ?∀)
 ;; ("\\ex"     ?∃)
 ;; ("\\to"     ?→)
 ;; ("\\*"    ?∗)
 ("\\lc"     ?⌜)
 ("\\rc"     ?⌝)
 ;; ("\\lam"    ?λ)
 ;; ("\\empty"  ?∅)
 ;; ("\\Lam"    ?Λ)
 ;; ("\\Sig"    ?Σ)
 ;; ("\\-"      ?∖)
 ;; ("\\aa"     ?●)
 ;; ("\\af"     ?◯)
 ;; ("\\iff"    ?↔)
 ;; ("\\gname"  ?γ)
 ;; ("\\incl"   ?≼)
 ;; ("\\latert" ?▶)
)
(mapc (lambda (x)
        (if (cddr x)
            (quail-defrule (cadr x) (car (cddr x)))))
      (append math-symbol-list-basic math-symbol-list-extended))
