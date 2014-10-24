(in-package algorithm-test)

(rem-all-tests)

#|
(deftest left-pos-t (algorithm::left-pos #(0 1 2 3 4) 2) 4)
(deftest left-pos-nil (algorithm::left-pos #(0 1 2 3 4) 3) nil)
(deftest right-pos-t (algorithm::right-pos #(0 1 2 3 4) 1) 3)
(deftest right-pos-nil (algorithm::right-pos #(0 1 2 3 4) 2) nil)
(deftest parent-pos-t1 (algorithm::parent-pos #(0 1 2 3 4) 3) 1)
(deftest parent-pos-t2 (algorithm::parent-pos #(0 1 2 3 4) 4) 2)
(deftest parent-pos-nil1 (algorithm::parent-pos #(0 1 2 3 4) 1) nil)
(deftest parent-pos-nil2 (algorithm::parent-pos #(0 1 2 3 4) 0) nil)
(deftest max-pos-t (algorithm::max-pos #(0 2 1 4 3) 1 2 3 4) 3)
(deftest max-heapify-t
    (let ((hp (vector 0 2 4 1 3)))
      (algorithm::max-heapify hp 1)
      hp) #(0 4 3 1 2))
(deftest build-max-heap-t
    (algorithm::build-max-heap (vector 0 1 2 3 4 5))
  #(0 5 4 3 1 2))
(deftest heap-sort-t
    (algorithm::heap-sort (vector 0 1 2 3 4 5))
  #(1 2 3 4 5))
(deftest quick-partition-t
    (let* ((lst (list 5 2 4 1 3))
           (i (algorithm::quick-partition lst 0 4)))
      (and (equal lst '(2 1 3 5 4)) (equal i 2))) t)
(deftest quick-sort-t
    (let ((result (list 5 2 4 1 3)))
      (algorithm::quick-sort result 0 4)
      result) (1 2 3 4 5))
|#
(deftest counting-sort-t1
    (algorithm::counting-sort (vector 5 4 1 3 2) 5)
  #(1 2 3 4 5))
(deftest counting-sort-t2
    (algorithm::counting-sort (vector 5 3 4 1 3 4 2) 5)
  #(1 2 3 3 4 4 5))
(defun test ()
  (do-tests))

