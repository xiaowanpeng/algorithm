(in-package algorithm-test)

(rem-all-tests)

#|
(deftest left-pos-t (left-pos #(0 1 2 3 4) 2) 4)
(deftest left-pos-nil (left-pos #(0 1 2 3 4) 3) nil)
(deftest right-pos-t (right-pos #(0 1 2 3 4) 1) 3)
(deftest right-pos-nil (right-pos #(0 1 2 3 4) 2) nil)
(deftest parent-pos-t1 (parent-pos #(0 1 2 3 4) 3) 1)
(deftest parent-pos-t2 (parent-pos #(0 1 2 3 4) 4) 2)
(deftest parent-pos-nil1 (parent-pos #(0 1 2 3 4) 1) nil)
(deftest parent-pos-nil2 (parent-pos #(0 1 2 3 4) 0) nil)
(deftest max-pos-t (max-pos #(0 2 1 4 3) 1 2 3 4) 3)
(deftest max-heapify-t
    (let ((hp (vector 0 2 4 1 3)))
      (max-heapify hp 1)
      hp) #(0 4 3 1 2))
(deftest build-max-heap-t
    (build-max-heap (vector 0 1 2 3 4 5))
  #(0 5 4 3 1 2))
|#
(deftest heap-sort-t
    (heap-sort (vector 0 1 2 3 4 5))
  #(1 2 3 4 5))

(defun test ()
  (do-tests))

