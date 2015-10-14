(cl:in-package #:asdf-user)

(defsystem :multipart-vfile-tree
  :version "0.1.0"
  :description "Multipart extensions for vfile-tree."
  :author "Cayman Nava"
  :license "MIT"
  :depends-on (:cl-ppcre :multipart-stream :path-string :vfile :vfile-tree)
  :components ((:module "src"
        :serial t
		:components
		((:file "package")
		 (:file "util")
		 (:file "multipart-vfile-tree"))))
  :long-description #.(uiop:read-file-string
		       (uiop:subpathname *load-pathname* "README.md"))
  :in-order-to ((test-op (test-op multipart-vfile-tree-test))))
