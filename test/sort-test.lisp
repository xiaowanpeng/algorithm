(in-package algorithm-test)

(rem-all-tests)

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
(deftest quick-sort-t
    (let ((result (list 5 2 4 1 3)))
      (algorithm::quick-sort result 0 4)
      result) (1 2 3 4 5))
(deftest quick-partition-t
    (let* ((lst (list 5 2 4 1 3))
           (i (algorithm::quick-partition lst 0 4)))
      (and (equal lst '(2 1 3 5 4)) (equal i 2))) t)
(deftest counting-sort-t2
    (algorithm::counting-sort (vector 5 3 4 1 3 4 2) 5)
  #(1 2 3 3 4 4 5))
(deftest counting-sort-t1
    (algorithm::counting-sort (vector 5 4 1 3 2) 5)
  #(1 2 3 4 5))

(defmacro bind-nodes (num &body body)
  (let ((result '()))
    (dotimes (i num)
      (setf result 
            (cons `(,(intern (format nil "NODE~a" i)) 
                     (make-instance 'algorithm::Tree-Node :val ,i))
                  result)))
    `(let ,(reverse result) ,@body)))

(deftest search-tree-insert-t
    (bind-nodes 5
      (progn
        (algorithm::tree-insert node3 node1)
        (algorithm::tree-insert node3 node2)
        (algorithm::tree-insert node3 node4)
        (algorithm::tree-insert node3 node0)
        (let ((act-val
               (list (algorithm::left-node node1)
                     (algorithm::right-node node1)
                     (algorithm::left-node node3)
                     (algorithm::right-node node3)))
              (exp-val (list node0 node2 node1 node4)))
          (equal act-val exp-val))))
  t)

(deftest search-tree-next-t
    (bind-nodes 5
      (progn
        (algorithm::tree-insert node3 node1)
        (algorithm::tree-insert node3 node2)
        (algorithm::tree-insert node3 node4)
        (algorithm::tree-insert node3 node0)
        (and
         (equal node4 (algorithm::tree-next node3))
         (equal node3 (algorithm::tree-next node2))
         (equal node2 (algorithm::tree-next node1))
         (equal node1 (algorithm::tree-next node0)))))
  t)

(deftest search-tree-pre-t
    (bind-nodes 5
      (progn
        (algorithm::tree-insert node3 node1)
        (algorithm::tree-insert node3 node2)
        (algorithm::tree-insert node3 node4)
        (algorithm::tree-insert node3 node0)
        (and
         (equal node3 (algorithm::tree-pre node4))
         (equal node2 (algorithm::tree-pre node3))
         (equal node1 (algorithm::tree-pre node2))
         (equal node0 (algorithm::tree-pre node1)))))
  t)

(deftest search-tree-del-t1
    (bind-nodes 5
      (progn
        (algorithm::tree-insert node3 node1)
        (algorithm::tree-insert node3 node2)
        (algorithm::tree-insert node3 node4)
        (algorithm::tree-insert node3 node0)
        (algorithm::tree-del node1)
        (and
         (equal node3 (algorithm::tree-pre node4))
         (equal node2 (algorithm::tree-pre node3))
         (equal node0 (algorithm::tree-pre node2)))))

  t)

(deftest search-tree-del-t2
    (bind-nodes 5
      (progn
        (algorithm::tree-insert node3 node1)
        (algorithm::tree-insert node3 node2)
        (algorithm::tree-insert node3 node4)
        (algorithm::tree-insert node3 node0)
        (algorithm::tree-del node1)
        (and
         (equal node4 (algorithm::tree-next node3))
         (equal node3 (algorithm::tree-next node2))
         (equal node2 (algorithm::tree-next node0)))))

  t)

(defun test ()
  (do-tests))

