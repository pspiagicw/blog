+++
title = "Building my dream NAS"
author = "pspiagicw"
date = 2025-05-25
draft = false
summary = "in 2026, nas is a required asset."
+++

I started tinkering with NAS and homelab stuff around 3 years go. I started with a old used laptop, one which didn't have a screen, had missing keys and didn't even have a battery inside it.
But it serviced me for quite a few months.


Then I got my first paycheck. I spent half of it getting a Lenovo ThinkCentre mini pc. Why ? Cause I thought it would be better than using a rasberry pi. Which turned out to be a great decision.

3 years later, I just bought my first proper NAS with quite a lot of drive bays and a pretty nice upgrade path.

The cons of using a Lenovo ThinkCentre is upgradability and storage addition. Most thinkcentres (depending on the model) can only support 1 disk (along with a m.2 nvme SSD). 
Plus most of them have locked down motherboard, you can't just willy-nilly change hardware inside it. Obviously the motherboard socket also determines the processor generation you can go upto.

## `my kickass nas`

I went with the Fractal Node 804, why ? Cause that's the only case I could find with large number of drive cages/bays. There are the Jonsbo N-series cases, but they are not available in my country.

I mean large cases like the Fractal North XL also has huge number of drive bays, but they are expensive and large!! I wanted something small that could live on my table without taking too much space.

The Node 804, is a M-ATX case, meaning it supports smaller motherboards compared to the large ATX ones.

But isn't there a Node 304 ? yes the tiniest form factor NAS case is the Node 304, the problem ? It's expensive, but moreover it's a itx case. 
A ITX Case only can fit itx motherboards, which are small and cute, but cost a kidney and are not available in countries like mine.
Plus ITX Cases mostly need sfx-power supplies, which are small power supplies.


Let's move on the other specs.

- Intel 10th Gen 10400T
- 32GB of DDR4 3200 
- 4 x 4 TB WD Red Plus NAS Hard Drives.
- MSI H510 Pro II M-ATX motherboard.
- Cooler Master Hyper 212 3DHP Black cooler.

## Why Intel 10th gen ?

You shouldn't go anything less than Intel 10th gen if you are building a homelab, the 10th gen iGPU supports a ton of video codecs for hardware docoding and encoding.
To take advantage of all that features, you need to take atleast 10th gen Intel.

With the Intel LGA 1700 sockets, the upgrade path includes the intel 13th and 14th gen CPUs which were known for their performance and heating issues. 
With the Intel LGA 1200 socket, I get a upgrade path to the Intel 11th gen, and to be honest I needed a cheap motherboard.

## The build
