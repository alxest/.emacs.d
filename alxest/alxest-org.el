(require-package 'org)
;http://randomgeekery.org/emacs/2014/05/16_exporting-from-org-to-markdown.html 
(custom-set-variables
 '(org-export-backends (quote (ascii html icalendar latex md))))  
(provide 'alxest-org)
