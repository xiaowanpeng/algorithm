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
                  (node-right right-node)
                  (node-parent parent-node)) ,node
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
                    ((or (null tmp-node) (equal tmp-node (,(intern left-node) (parent-node tmp-node)))) 
                     (if (null tmp-node) tmp-node (parent-node tmp-node)))))))))

(define-next-pre tree-next)
(define-next-pre tree-pre)

(defmethod tree-insert ((tree Tree-Node) (node Tree-Node))
  (with-tree-node tree node
    (cond ((and (<= node-val tree-val) (null tree-left))
           (setf tree-left node) (setf node-parent tree))
          ((and (<= node-val tree-val) tree-left)
           (tree-insert tree-left node))
          ((and (> node-val tree-val) (null tree-right))
           (setf tree-right node) (setf node-parent tree))
          ((and (> node-val tree-val) tree-right)
           (tree-insert tree-right node)))))

(defmethod print-object ((obj Tree-Node) s)
  (with-slots (left-node node-val right-node) obj
    (format s "(~a ~a ~a)~%" 
            (if left-node (node-val left-node) nil) 
            node-val
            (if right-node (node-val right-node) nil))))

(defmacro with-node (node &body body)
  `(with-slots ((node-val node-val)
                (node-left left-node)
                (node-right right-node)
                (node-parent parent-node)) ,node
     ,@body))

(defmethod chg-node-pos ((node Tree-Node) new-node)
  (with-node node
   (if (equal node (left-node node-parent))
       (setf (left-node node-parent) new-node)
       (setf (right-node node-parent) new-node))))

(defmethod tree-del ((node Tree-Node))
  (with-node node
    (cond ((and (null node-left) (null node-right))
           (chg-node-pos node nil))
          ((and (null node-left) node-right)
           (chg-node-pos node node-right)
           (setf (parent-node node-right) node-parent))
          ((and (null node-right) node-left)
           (chg-node-pos node node-left)
           (setf (parent-node node-left) node-parent))
          (t (let ((next-node (tree-next node)))
               (tree-del next-node)
               (chg-node-pos node next-node)
               (setf (parent-node next-node) node-parent)
               (setf (parent-node node-left) next-node)
               (setf (left-node next-node) node-left)
               (when node-right (setf (parent-node node-right) next-node))
               (setf (right-node next-node) node-right))))))
