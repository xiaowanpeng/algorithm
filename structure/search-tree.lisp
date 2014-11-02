(in-package algorithm)

(defclass Tree-Node ()
  ((node-val :initform nil :accessor node-val :initarg :val)
   (left-node :initform nil :accessor left-node)
   (right-node :initform nil :accessor right-node)
   (parent-node :initform nil :accessor parent-node)))

(defmacro with-tree-node (tree node &body body)
  `(with-slots ((tree-val node-val)
                (tree-left left-node)
                (tree-right right-node)) ,tree
     (with-slots ((node-val node-val)
                  (node-left left-node)
                  (node-right right-node)) ,node
       ,@body)))

(defmethod tree-search ((tree Tree-Node) (node Tree-Node))
  (with-tree-node tree node
    (cond ((equal tree-val node-val) tree)
          ((<= node-val tree-val) (tree-search tree-left node))
          (t (tree-search tree-right node)))))

(defmethod tree-min ((tree Tree-Node))
  (if (null (left-node tree))
      tree
      (tree-min (left-node tree))))

(defmethod tree-max ((tree Tree-Node))
  (if (null (right-node tree))
      tree
      (tree-max (right-node tree))))

(defmacro define-next-pre (name)
  (let ((tree-min (if (eql name 'tree-next) "TREE-MIN" "TREE-MAX"))
        (right-node (if (eql name 'tree-next) "RIGHT-NODE" "LEFT-NODE"))
        (left-node (if (eql name 'tree-next) "LEFT-NODE" "RIGHT-NODE")))
    `(defmethod ,name ((node Tree-Node))
       (cond ((not (null (,(intern right-node) node))) 
              (,(intern tree-min) (,(intern right-node) node)))
             ((null (parent-node node)) nil)
             ((equal node (,(intern left-node) (parent-node node)))
              (parent-node node))
             (t (do ((tmp-node (parent-node node) (parent-node tmp-node)))
                    ((or (equal tmp-node (,(intern left-node) tmp-node)) (null tmp-node)) 
                     (if (null tmp-node) tmp-node (parent-node tmp-node)))))))))

(define-next-pre tree-next)
(define-next-pre tree-pre)

(defmethod tree-insert ((tree Tree-Node) (node Tree-Node))
  (with-tree-node tree node
    (cond ((and (<= node-val tree-val) (null tree-left))
           (format t "1")
           (setf tree-left node))
          ((and (<= node-val tree-val) tree-left)
           (format t "2")
           (tree-insert tree-left node))
          ((and (> node-val tree-val) (null tree-right))
           (format t "3")
           (setf tree-right node))
          ((and (> node-val tree-val) tree-right)
           (format t "4")
           (tree-insert tree-right node)))))
