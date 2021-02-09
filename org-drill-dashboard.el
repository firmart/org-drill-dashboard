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
