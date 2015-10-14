(cl:in-package #:cl-user)

(defpackage #:multipart-vfile-tree
  (:use #:cl)
  (:import-from #:cl-ppcre
                #:regex-replace-all)
  (:import-from #:multipart-stream
                #:multipart-stream
                #:multipart-headers
                #:multipart-use-headers-p
                #:make-multipart-stream
                #:make-boundary)
  (:import-from #:path-string
                #:dirname)
  (:import-from #:vfile
                #:vfile-base
                #:vfile-path
                #:vfile-directory-p)
  (:import-from #:vfile-tree
                #:vfile-node
                #:vfile-open
                #:vfile-directory-open
                #:vfile-children
                #:traverse-filesystem)
  (:export #:multipart-vfile-node
           #:multipart-use-headers-p
           #:multipart-vfile-boundary
           #:make-multipart-vfile-tree))
