;; Load the publishing system
(require 'ox-publish)

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "org-site:main"
             :recursive t
             :base-directory "./content"
             :publishing-function 'org-html-publish-to-html
             :publishing-directory "./docs"
             :with-author nil           ;; Don't include author name
             :with-creator nil            ;; Include Emacs and Org versions in footer
             :with-toc nil                ;; Include a table of contents
             :section-numbers nil       ;; Don't include section numbers
             :time-stamp-file nil)))    ;; Don't include time stamp in file

(setq org-html-validation-link nil)


;; Customize the HTML output
(setq org-html-validation-link nil            ;; Don't show validation link
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style nil ;; Use our own styles
      org-html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"simple.css\" />")

;; Customize the HTML output
;;(setq org-html-validation-link nil            ;; Don't show validation link
;;      org-html-head-include-scripts nil       ;; Use our own scripts
;;      org-html-head-include-default-style nil ;; Use our own styles
;;      org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />")


;; Make external links (http/https) open in a new tab in HTML export.
(require 'ox-html)

(defun framirez/org-html-external-links-new-tab (link backend _info)
  "Add target=_blank and rel=noopener noreferrer to external links in HTML export."
  (when (and (eq backend 'html)
             (string-match-p "href=\"https?://" link)
             (not (string-match-p "target=\"" link)))
    ;; Insert attributes right after the <a
    (replace-regexp-in-string
     "<a\\b"
     "<a target=\"_blank\" rel=\"noopener noreferrer\""
     link
     t t)))

(add-to-list 'org-export-filter-link-functions
             #'framirez/org-html-external-links-new-tab)

;; Generate the site output
(org-publish-all t)

(message "Build complete!")
