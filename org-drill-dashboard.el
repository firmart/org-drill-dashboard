;;; org-drill-dashboard.el --- A dashboard for org-drill -*- lexical-binding: t; -*-

;; Copyright (C) 2021 Firmin Martin

;; Author: Firmin Martin
;; Maintainer: Firmin Martin
;; Version: 0.1
;; Keywords: dashboard
;; URL: https://www.github.com/firmart/org-drill-dashboard
;; Package-Requires: ((emacs "25.1") (org "9.3") (org-drill "2.7") (cl-lib "0.5"))

;; This program is free software: you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation, either version 3 of
;; the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Org-drill-dashboard is an org-mode extension that provides a comprehensive
;; visualization of org-drill files.

;; external libraries
(require 'org)

;; built-in Emacs lib
(require 'cl-lib)     ;; Common-lisp emulation library

;;; Code:
;;; Custom group
;;;; General settings
(defgroup org-drill-dashboard nil
  "Org-drill-dashboard settings."
  :group 'org
  :package-version '(org-drill-dashboard . "0.1"))

;; TODO each file is a section
(defcustom org-drill-dashboard-files nil
  "List of org-drill files to monitor."
  :type  '(repeat file)
  :group 'org-drill-dashboard
  :package-version '(org-drill-dashboard . "0.1"))

(defun org-drill-dashboard-entry-data ()
  "Return a property list of the org-drill entry at point."
  (let (data)
    (setq data (plist-put data :id (org-entry-get (point) "ID")))
    (setq data (plist-put data :title (org-entry-get (point) "ITEM")))
    (setq data (plist-put data :avg-quality (org-drill-entry-average-quality)))
    (setq data (plist-put data :ease (org-drill-entry-ease)))
    (setq data (plist-put data :empty (org-drill-entry-empty-p)))
    (setq data (plist-put data :failure-count (org-drill-entry-failure-count)))
    (setq data (plist-put data :last-interval (org-drill-entry-last-interval)))
    (setq data (plist-put data :last-quality (org-drill-entry-last-quality)))
    (setq data (plist-put data :leech (org-drill-entry-leech-p)))
    (setq data (plist-put data :new (org-drill-entry-new-p)))
    (setq data (plist-put data :repeats-since-fail (org-drill-entry-repeats-since-fail)))
    (setq data (plist-put data :total-repeats (org-drill-entry-total-repeats)))))

(defun org-drill-dashboard-data-list (file)
  "Return a data list of an org-drill FILE."
  (let (data-list)
    (with-temp-buffer
      (insert-file-contents file)
      (org-mode) ;; required to fetch the heading
      (while (not (= (point) (point-max)))
	(org-next-visible-heading 1)
	(when (member "drill" (org-get-tags nil t)) ;; exclude inherited tags
	  (add-to-list 'data-list (org-drill-dashboard-entry-data)))))
    data-list))

(defun org-drill-dashboard-empty-count (data-list)
  "Return the number of empty entry from the DATA-LIST of an org-drill file."
  (cl-loop for data in data-list
	   sum (if (plist-get data-list :empty) 1 0)))

(defun org-drill-dashboard-new-count (data-list)
  "Return the number of new entries from the DATA-LIST of an org-drill file."
  (cl-loop for data in data-list
	   sum (if (plist-get data-list :new) 1 0)))

(defun org-drill-dashboard-leech-count (data-list)
  "Return the number of leech entries from the DATA-LIST of an org-drill file."
  (cl-loop for data in data-list
	   sum (if (plist-get data-list :leech) 1 0)))

(defun org-drill-dashboard-avg-avg-quality (data-list)
  "Return the average quality's average of entries from the DATA-LIST of an org-drill file."
  (/ (apply #'+ (mapcar (lambda (d) (let ((avg-quality (plist-get d :avg-quality))) (or avg-quality 0))) data-list))
     (length data-list)))

    (provide 'org-drill-dashboard)
;;; org-drill-dashboard.el ends here
