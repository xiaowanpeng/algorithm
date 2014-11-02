;;;; -*- Mode: Lisp -*-

(defsystem algorithm
    :name "algorithm"
    :author "shawwp@126.com"
    :licence "BSD"
    :description "Implementation of <Introduction to Algorithms>"
    :components ((:file "package")
                 (:module "sort"
                  :depends-on ("package")
		  :components ((:file "heap")
                               (:file "quick")
                               (:file "linear")))
                 (:module "structure"
                  :depends-on ("package")
                  :components ((:file "search-tree")))))

