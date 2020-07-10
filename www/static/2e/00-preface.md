# Preface {-}

Data science is an exciting field to work in. It’s also still very young. Unfortunately, many people, and especially companies, believe that you need new technology in order to tackle the problems posed by data science. However, as this book demonstrates, many things can be accomplished by using the command line instead, and sometimes in a much more efficient way.

Around five years ago, during my PhD program, I gradually switched from using Microsoft Windows to Linux. Because it was a bit scary at first, I started with having both operating systems installed next to each other (known as dual-boot). The urge to switch back and forth between Microsoft Windows faded and at some point I was even tinkering around with Arch Linux, which allows you to build up your own custom Linux machine from scratch. All you’re given is the command line, and it’s up to you what you want to make of it. Out of necessity I quickly became very comfortable using the command line. Eventually, as spare time got more precious, I settled down with a Linux distribution known as Ubuntu because of its ease of use and large community. However, the command line is still where I’m spending most of time.

It actually hasn’t been too long ago that I realized that the command line is not just for installing software, system configuration, and searching files. I started learning about command-line tools such as `cut`, `sort`, and `sed`. These are examples of command-line tools that take data as input, do something to it, and print the result. Ubuntu comes with quite a few of them. Once I understood the potential of combining these small tools, I was hooked.

After my PhD, when I became a data scientist, I wanted to use this approach to do data science as much as possible. Thanks to a couple of new, open-source command-line tools including `xml2json`, `jq`, and `json2csv` I was even able to use the command line for tasks such as scraping websites and processing lots of JSON data. In September 2013, I decided to write a blog post titled *Seven Command-line Tools for Data Science*, which is available at <http://www.jeroenjanssens.com/2013/09/19/seven-command-line-tools-for-data-science.html>. To my surprise, the blog post got quite some attention and I received a lot of suggestions of other command-line tools. I started wondering whether this blog post could be turned into a book. I’m pleased that, some ten months later, with the help of many talented people (see the acknowledgments below), the answer is a yes.

I am sharing this personal story not so much because I think you should know how this book came about, but because I want to you know that I had to learn about the command line as well. Because the command line is so different from using a graphical user interface, it can seem scary at first. But if I can learn it, then you can as well. No matter what your current operating system is and no matter how you currently work with data, after reading this book you will be able to do data science at the command line. If you’re already familiar with the command line, or even if you’re already dreaming in shell scripts, chances are that you’ll still discover a few interesting tricks or command-line tools to use for your next data science project.

## What to Expect from This Book {-}

In this book, we’re going to obtain, scrub, explore, and model data - a lot of it. This book is not so much about how become *better* at those data science tasks. There are already great resources available that discuss, for example, when to apply which statistical test or how data can be best visualized. Instead, this practical book aims to make you more *efficient* and *productive* by teaching you how to perform those data science tasks at the command line.

While this book discusses over 80 command-line tools, it’s not the tools themselves that matter most. Some command-line tools have been around for a very long time, while others will be replaced by better ones. There are even command-line tools that are being created as you’re reading this. In the past nine months, I have discovered many amazing command-line tools. Unfortunately, some of them were discovered too late to be included in the book. In short, command-line tools come and go. But that’s OK.

What matters most is the underlying idea of working with tools, pipes, and data. Most of the command-line tools do one thing and do it well. This is part the UNIX philosophy, which makes several appearances throughout the book. Once you become familiar with the command line, know how to combine command-line tools, and can even create new ones, you have developed an invaluable skill.

## How to Read This Book {-}

In general, you’re advised to read this book in a linear fashion. Once a concept or command-line tool has been introduced, chances are that we employ it in a later chapter. For example, in Chapter 9, we make heavy use of `parallel`, which is introduced extensively in Chapter 8.

Data science is a broad field that intersects many other fields such as programming, data visualization, and machine learning. As a result, this book touches on many interesting topics which unfortunately cannot be discussed at full length. Throughout the book, there are suggestions for additional reading. It’s not required to read this material in order to follow along with the book, but when you are interested, you know that there’s much more to learn.

## Who This Book Is For {-}

This book makes just one assumption about you: that you work with data. It doesn’t matter which programming language or statistical computing environment you’re currently using. The book explains all the necessary concepts from the beginning.

It also doesn’t matter whether your operating system is Microsoft Windows, MacOS, or some form of Linux. The book comes with a Docker image, which is an easy-to-install virtual environment. It allows you to run the command-line tools and follow along with the code examples in the same environment as this book was written. You don’t have to waste time figuring out how to install all the command-line tools and their dependencies.

The book contains some code in Bash, Python, and R so it’s helpful if you have some programming experience, but it’s by no means required to follow along with the examples.


## Acknowledgments {-}

First of all, I’d like to thank Mike Dewar and Mike Loukides for believing that my blog post [Seven Command-Line Tools for Data Science](http://jeroenjanssens.com/2013/09/19/seven-command-line-tools-for-data-science.html), which I wrote in September 2013, could be expanded into a book.

Special thanks to my technical reviewers Mike Dewar, Brian Eoff, and Shane Reustle for reading various drafts, meticulously testing all the commands, and providing invaluable feedback. Your efforts have improved the book greatly. The remaining errors are entirely my own responsibility.

I had the privilege of working together with three amazing editors, namely: Ann Spencer, Julie Steele, and Marie Beaugureau. Thank you for your guidance and for being such great liaisons with the many talented people at O’Reilly. Those people include: Laura Baldwin, Huguette Barriere, Sophia DeMartini, Yasmina Greco, Rachel James, Ben Lorica, Mike Loukides, and Christopher Pappas. There are many others whom I haven’t met because they are operating behind the scenes. Together they ensured that working with O’Reilly has truly been a pleasure.

This book discusses over 80 command-line tools. Needless to say, without these tools, this book wouldn’t have existed in the first place. I’m therefore extremely grateful to all the authors who created and contributed to these tools. The complete list of authors is unfortunately too long to include here; they are mentioned in the Appendix. Thanks especially to Aaron Crow, Jehiah Czebotar, Christoph Groskopf, Dima Kogan, Sergey Lisitsyn, Francisco J. Martin, and Ole Tange for providing help with their amazing command-line tools.

Eric Postma and Jaap van den Herik, who supervised me during my PhD program, deserve a special thank you. Over the course of five years they have taught me many lessons. Although writing a technical book is quite different from writing a PhD thesis, many of those lessons proved to be very helpful in the past nine months as well.

Finally, I’d like to thank my colleagues at YPlan, my friends, my family, and especially my wife Esther for supporting me and for pulling me away from the command line at just the right times.

## Dedication {-}

*To my wife, Esther. Without her encouragement, support, and patience, this book would surely have ended up in `/dev/null`.*


## About the Author {-}


[Jeroen Janssens](http://jeroenjanssens.com/) is the founder and CEO of [Data Science Workshops](https://datascienceworkshops.com), which provides on-the-job training and coaching in data visualisation, machine learning, and programming. Previously, he was an assistant professor at Jheronimus Academy of Data Science and a data scientist at Elsevier in Amsterdam and startups YPlan and Outbrain in New York City. He is the author of Data Science at the Command Line, published by O’Reilly Media. Jeroen holds a PhD in machine learning from Tilburg University and an MSc in artificial intelligence from Maastricht University. He can be found on [Twitter](https://twitter.com/jeroenhjanssens/), [LinkedIn](http://www.linkedin.com/in/jeroenjanssens), and [GitHub](https://github.com/jeroenjanssens).

