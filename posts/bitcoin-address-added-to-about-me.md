---
title: 'Bitcoin address added to About Me'
date: '2014-01-03'
description: A post describing the addition of my public bitcoin address to my About Me page
categories: bitcoin
tags: [bitcoin-address, about-me]
---

I've added a QR code and link to my bitcoin public address.  I did this
not really because I expect anyone to send me money but rather so I
could have the experience and so I could have a way for people return
money I send.

See, one of the best ways to get people interested in Bitcoin is to put
some in their hands.  As long as transaction fees are low, it's pretty
easy to do.  If one is a Chrome user, it's as simple as loading the
[KryptoKit](https://chrome.google.com/webstore/detail/kryptokit/lhhipingoaiddcoalochnbjlkifbpmoj?hl=en)
extension and getting them to create an address and copy/paste it to
you.

While you don't want to send any more than you can afford to lose, if
you trust the person it can be an eye-opening experience for them to
have a couple-hundred dollars worth of bitcoin show up in their wallet
in the space of a couple minutes.  I wouldn't do it with a stranger in
that amount, but a family member or trusted friend can really understand
the power of Bitcoin in a couple minutes in a way that they can't with
just an explanation.

While KryptoKit is a fine wallet, it's not really safe to store large
amounts unless you've got an encrypted backup of the private key.
That's not something I worry about in my little demo, so don't leave
your bitcoin in the unbacked-up wallet for long.  Have them transfer it
back to you to complete the demo.

Since KryptoKit can pick up addresses from web pages, the easiest way
for me to complete the demo is to have the person visit my blog's About
Me page and have KryptoKit fill in the address from the page.

First I had to understand the [Bitcoin URI
format](https://github.com/bitcoin/bips/blob/master/bip-0021.mediawiki).
I just made a simple uri with my address like
`bitcoin:1FL4vuNSc5Y2m13wCp5jNWwbMcMErC4oqa`.  KryptoKit will see that
in the page and make it available to the sender as a clickable
destination.

I also generated a QR code for the page, which can be scanned by a
smartphone or webcam.  I used this [Bitcoin URI
generator](http://qr.ma.eatgold.com/index.php), which includes a snazzy
bitcoin logo in the center of the code.  I checked the code, and the
site did faithfully make a QR code for my address.  Right-click the
image and save it, et voila.

Visit the [About Me](/about) page to see the result.

That's it.
