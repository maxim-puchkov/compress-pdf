# Compress PDF
Significantly reduce the file size of scanned PDF documents without noticeable loss of quality.  


## Install 
To install the `compress-pdf`

You can quickly run the project with the following command:
```
swift run compress-pdf [--replace-files] [--suffix <suffix>] [<files> ...]
```

You can build compress-pdf for release like so:
```
swift build --configuration release
```


## Usage
*  `compress-pdf` is particullarly effective for documents that were scanned with iPhone.  
*  Move a scanned PDF document to your computer and run this command in your Terminal:  
```shell
compress-pdf [--replace-files] [--suffix <suffix>] [<files> ...]

ARGUMENTS:
  <files>                 The PDF files to compress.

OPTIONS:
  -r, --replace-files     Replace original PDF files.
  -s, --suffix <suffix>   Set file suffix added to copied PDF files. (default:  (compressed))
  -h, --help              Show help information.
```
*  This command compresses a copy of the original `input.pdf` and saves it in the file named `input (compressed).pdf`. 


## Examples
*  Take a look at the size of three example PDF files and the size of compressed PDF files generated with `compress-pdf` below:

| Original File                                              | Compressed File                                   | Percentage Decrease (Bytes)                           |
|-----------------------------------------------|---------------------------------------------|---------------------------------------------|
| [01-scanned-document.pdf](Examples/01-scanned-document.pdf) (9.5 MB)       | [01-compressed.pdf](Examples/01-compressed.pdf) (329 KB)      | 96.554%      |
| [02-scanned-document.pdf](Examples/02-scanned-document.pdf) (12.1 MB)     | [02-compressed.pdf](Examples/02-compressed.pdf) (429 KB)      | 96.459%      |
| [03-scanned-document.pdf](Examples/03-scanned-document.pdf) (9.1 MB)       | [03-compressed.pdf](Examples/03-compressed.pdf) (312 KB)      | 96.552%      |

>  **Note**: all documents were scanned in the **Files** iPhone app. 
