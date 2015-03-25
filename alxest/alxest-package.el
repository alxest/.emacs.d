(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(defun require-package (package)
  "Install package if not yet installed, then execute (require package)"
  (unless (package-installed-p package)
      (progn (unless (assoc package package-archive-contents)
	       (package-refresh-contents))
	     (package-install package)))
  (require package))

(provide 'alxest-package)
