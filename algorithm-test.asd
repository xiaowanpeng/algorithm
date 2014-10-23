;;;; -*- Mode: Lisp -*-

(defsystem algorithm-test
    :name "algorithm-test"
    :author "shawwp@126.com"
    :licence "BSD"
    :description "Test implementation of <Introduction to Algorithms>"
    :depends-on (:algorithm :rt)
    :components ((:file "package-test")
                 (:module "test"
                  :depends-on ("package-test")
		  :components ((:file "sort-test")))))

