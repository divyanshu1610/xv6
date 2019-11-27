
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc c0 b5 10 80       	mov    $0x8010b5c0,%esp
8010002d:	b8 b0 2e 10 80       	mov    $0x80102eb0,%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx
  initlock(&bcache.lock, "bcache");

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb f4 b5 10 80       	mov    $0x8010b5f4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 40 71 10 80       	push   $0x80107140
80100051:	68 c0 b5 10 80       	push   $0x8010b5c0
80100056:	e8 45 43 00 00       	call   801043a0 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 0c fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd0c
80100062:	fc 10 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 10 fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd10
8010006c:	fc 10 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba bc fc 10 80       	mov    $0x8010fcbc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 47 71 10 80       	push   $0x80107147
80100097:	50                   	push   %eax
80100098:	e8 f3 41 00 00       	call   80104290 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d bc fc 10 80       	cmp    $0x8010fcbc,%eax
801000bb:	72 c3                	jb     80100080 <binit+0x40>
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 c0 b5 10 80       	push   $0x8010b5c0
801000e4:	e8 a7 43 00 00       	call   80104490 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 10 fd 10 80    	mov    0x8010fd10,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 0c fd 10 80    	mov    0x8010fd0c,%ebx
80100126:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 c0 b5 10 80       	push   $0x8010b5c0
80100162:	e8 49 44 00 00       	call   801045b0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 5e 41 00 00       	call   801042d0 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 ad 1f 00 00       	call   80102130 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 4e 71 10 80       	push   $0x8010714e
80100198:	e8 f3 01 00 00       	call   80100390 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 bd 41 00 00       	call   80104370 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
  iderw(b);
801001c4:	e9 67 1f 00 00       	jmp    80102130 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 5f 71 10 80       	push   $0x8010715f
801001d1:	e8 ba 01 00 00       	call   80100390 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 7c 41 00 00       	call   80104370 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 2c 41 00 00       	call   80104330 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010020b:	e8 80 42 00 00       	call   80104490 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 4f 43 00 00       	jmp    801045b0 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 66 71 10 80       	push   $0x80107166
80100269:	e8 22 01 00 00       	call   80100390 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 eb 14 00 00       	call   80101770 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028c:	e8 ff 41 00 00       	call   80104490 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 a0 ff 10 80    	mov    0x8010ffa0,%edx
801002a7:	39 15 a4 ff 10 80    	cmp    %edx,0x8010ffa4
801002ad:	74 2c                	je     801002db <consoleread+0x6b>
801002af:	eb 5f                	jmp    80100310 <consoleread+0xa0>
801002b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b8:	83 ec 08             	sub    $0x8,%esp
801002bb:	68 20 a5 10 80       	push   $0x8010a520
801002c0:	68 a0 ff 10 80       	push   $0x8010ffa0
801002c5:	e8 f6 3a 00 00       	call   80103dc0 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 a0 ff 10 80    	mov    0x8010ffa0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 a4 ff 10 80    	cmp    0x8010ffa4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 20 35 00 00       	call   80103800 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 a5 10 80       	push   $0x8010a520
801002ef:	e8 bc 42 00 00       	call   801045b0 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 94 13 00 00       	call   80101690 <ilock>
        return -1;
801002fc:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100302:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100307:	5b                   	pop    %ebx
80100308:	5e                   	pop    %esi
80100309:	5f                   	pop    %edi
8010030a:	5d                   	pop    %ebp
8010030b:	c3                   	ret    
8010030c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100310:	8d 42 01             	lea    0x1(%edx),%eax
80100313:	a3 a0 ff 10 80       	mov    %eax,0x8010ffa0
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 20 ff 10 80 	movsbl -0x7fef00e0(%eax),%eax
    if(c == C('D')){  // EOF
80100324:	83 f8 04             	cmp    $0x4,%eax
80100327:	74 3f                	je     80100368 <consoleread+0xf8>
    *dst++ = c;
80100329:	83 c6 01             	add    $0x1,%esi
    --n;
8010032c:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
8010032f:	83 f8 0a             	cmp    $0xa,%eax
    *dst++ = c;
80100332:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n')
80100335:	74 43                	je     8010037a <consoleread+0x10a>
  while(n > 0){
80100337:	85 db                	test   %ebx,%ebx
80100339:	0f 85 62 ff ff ff    	jne    801002a1 <consoleread+0x31>
8010033f:	8b 45 10             	mov    0x10(%ebp),%eax
  release(&cons.lock);
80100342:	83 ec 0c             	sub    $0xc,%esp
80100345:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100348:	68 20 a5 10 80       	push   $0x8010a520
8010034d:	e8 5e 42 00 00       	call   801045b0 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 36 13 00 00       	call   80101690 <ilock>
  return target - n;
8010035a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010035d:	83 c4 10             	add    $0x10,%esp
}
80100360:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100363:	5b                   	pop    %ebx
80100364:	5e                   	pop    %esi
80100365:	5f                   	pop    %edi
80100366:	5d                   	pop    %ebp
80100367:	c3                   	ret    
80100368:	8b 45 10             	mov    0x10(%ebp),%eax
8010036b:	29 d8                	sub    %ebx,%eax
      if(n < target){
8010036d:	3b 5d 10             	cmp    0x10(%ebp),%ebx
80100370:	73 d0                	jae    80100342 <consoleread+0xd2>
        input.r--;
80100372:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
80100378:	eb c8                	jmp    80100342 <consoleread+0xd2>
8010037a:	8b 45 10             	mov    0x10(%ebp),%eax
8010037d:	29 d8                	sub    %ebx,%eax
8010037f:	eb c1                	jmp    80100342 <consoleread+0xd2>
80100381:	eb 0d                	jmp    80100390 <panic>
80100383:	90                   	nop
80100384:	90                   	nop
80100385:	90                   	nop
80100386:	90                   	nop
80100387:	90                   	nop
80100388:	90                   	nop
80100389:	90                   	nop
8010038a:	90                   	nop
8010038b:	90                   	nop
8010038c:	90                   	nop
8010038d:	90                   	nop
8010038e:	90                   	nop
8010038f:	90                   	nop

80100390 <panic>:
{
80100390:	55                   	push   %ebp
80100391:	89 e5                	mov    %esp,%ebp
80100393:	56                   	push   %esi
80100394:	53                   	push   %ebx
80100395:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100398:	fa                   	cli    
  cons.locking = 0;
80100399:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 92 23 00 00       	call   80102740 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 6d 71 10 80       	push   $0x8010716d
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 43 7b 10 80 	movl   $0x80107b43,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 e3 3f 00 00       	call   801043c0 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 81 71 10 80       	push   $0x80107181
801003ed:	e8 6e 02 00 00       	call   80100660 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
80100400:	00 00 00 
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100410 <consputc>:
  if(panicked){
80100410:	8b 0d 58 a5 10 80    	mov    0x8010a558,%ecx
80100416:	85 c9                	test   %ecx,%ecx
80100418:	74 06                	je     80100420 <consputc+0x10>
8010041a:	fa                   	cli    
8010041b:	eb fe                	jmp    8010041b <consputc+0xb>
8010041d:	8d 76 00             	lea    0x0(%esi),%esi
{
80100420:	55                   	push   %ebp
80100421:	89 e5                	mov    %esp,%ebp
80100423:	57                   	push   %edi
80100424:	56                   	push   %esi
80100425:	53                   	push   %ebx
80100426:	89 c6                	mov    %eax,%esi
80100428:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
8010042b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100430:	0f 84 b1 00 00 00    	je     801004e7 <consputc+0xd7>
    uartputc(c);
80100436:	83 ec 0c             	sub    $0xc,%esp
80100439:	50                   	push   %eax
8010043a:	e8 21 59 00 00       	call   80105d60 <uartputc>
8010043f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100442:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100447:	b8 0e 00 00 00       	mov    $0xe,%eax
8010044c:	89 da                	mov    %ebx,%edx
8010044e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010044f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100454:	89 ca                	mov    %ecx,%edx
80100456:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100457:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010045a:	89 da                	mov    %ebx,%edx
8010045c:	c1 e0 08             	shl    $0x8,%eax
8010045f:	89 c7                	mov    %eax,%edi
80100461:	b8 0f 00 00 00       	mov    $0xf,%eax
80100466:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100467:	89 ca                	mov    %ecx,%edx
80100469:	ec                   	in     (%dx),%al
8010046a:	0f b6 d8             	movzbl %al,%ebx
  pos |= inb(CRTPORT+1);
8010046d:	09 fb                	or     %edi,%ebx
  if(c == '\n')
8010046f:	83 fe 0a             	cmp    $0xa,%esi
80100472:	0f 84 f3 00 00 00    	je     8010056b <consputc+0x15b>
  else if(c == BACKSPACE){
80100478:	81 fe 00 01 00 00    	cmp    $0x100,%esi
8010047e:	0f 84 d7 00 00 00    	je     8010055b <consputc+0x14b>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100484:	89 f0                	mov    %esi,%eax
80100486:	0f b6 c0             	movzbl %al,%eax
80100489:	80 cc 07             	or     $0x7,%ah
8010048c:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
80100493:	80 
80100494:	83 c3 01             	add    $0x1,%ebx
  if(pos < 0 || pos > 25*80)
80100497:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010049d:	0f 8f ab 00 00 00    	jg     8010054e <consputc+0x13e>
  if((pos/80) >= 24){  // Scroll up.
801004a3:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004a9:	7f 66                	jg     80100511 <consputc+0x101>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004ab:	be d4 03 00 00       	mov    $0x3d4,%esi
801004b0:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b5:	89 f2                	mov    %esi,%edx
801004b7:	ee                   	out    %al,(%dx)
801004b8:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
  outb(CRTPORT+1, pos>>8);
801004bd:	89 d8                	mov    %ebx,%eax
801004bf:	c1 f8 08             	sar    $0x8,%eax
801004c2:	89 ca                	mov    %ecx,%edx
801004c4:	ee                   	out    %al,(%dx)
801004c5:	b8 0f 00 00 00       	mov    $0xf,%eax
801004ca:	89 f2                	mov    %esi,%edx
801004cc:	ee                   	out    %al,(%dx)
801004cd:	89 d8                	mov    %ebx,%eax
801004cf:	89 ca                	mov    %ecx,%edx
801004d1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004d2:	b8 20 07 00 00       	mov    $0x720,%eax
801004d7:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801004de:	80 
}
801004df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004e2:	5b                   	pop    %ebx
801004e3:	5e                   	pop    %esi
801004e4:	5f                   	pop    %edi
801004e5:	5d                   	pop    %ebp
801004e6:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e7:	83 ec 0c             	sub    $0xc,%esp
801004ea:	6a 08                	push   $0x8
801004ec:	e8 6f 58 00 00       	call   80105d60 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 63 58 00 00       	call   80105d60 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 57 58 00 00       	call   80105d60 <uartputc>
80100509:	83 c4 10             	add    $0x10,%esp
8010050c:	e9 31 ff ff ff       	jmp    80100442 <consputc+0x32>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100511:	52                   	push   %edx
80100512:	68 60 0e 00 00       	push   $0xe60
    pos -= 80;
80100517:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010051a:	68 a0 80 0b 80       	push   $0x800b80a0
8010051f:	68 00 80 0b 80       	push   $0x800b8000
80100524:	e8 97 41 00 00       	call   801046c0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100529:	b8 80 07 00 00       	mov    $0x780,%eax
8010052e:	83 c4 0c             	add    $0xc,%esp
80100531:	29 d8                	sub    %ebx,%eax
80100533:	01 c0                	add    %eax,%eax
80100535:	50                   	push   %eax
80100536:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
80100539:	6a 00                	push   $0x0
8010053b:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
80100540:	50                   	push   %eax
80100541:	e8 ca 40 00 00       	call   80104610 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 85 71 10 80       	push   $0x80107185
80100556:	e8 35 fe ff ff       	call   80100390 <panic>
    if(pos > 0) --pos;
8010055b:	85 db                	test   %ebx,%ebx
8010055d:	0f 84 48 ff ff ff    	je     801004ab <consputc+0x9b>
80100563:	83 eb 01             	sub    $0x1,%ebx
80100566:	e9 2c ff ff ff       	jmp    80100497 <consputc+0x87>
    pos += 80 - pos%80;
8010056b:	89 d8                	mov    %ebx,%eax
8010056d:	b9 50 00 00 00       	mov    $0x50,%ecx
80100572:	99                   	cltd   
80100573:	f7 f9                	idiv   %ecx
80100575:	29 d1                	sub    %edx,%ecx
80100577:	01 cb                	add    %ecx,%ebx
80100579:	e9 19 ff ff ff       	jmp    80100497 <consputc+0x87>
8010057e:	66 90                	xchg   %ax,%ax

80100580 <printint>:
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d3                	mov    %edx,%ebx
80100588:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100590:	74 04                	je     80100596 <printint+0x16>
80100592:	85 c0                	test   %eax,%eax
80100594:	78 5a                	js     801005f0 <printint+0x70>
    x = xx;
80100596:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  i = 0;
8010059d:	31 c9                	xor    %ecx,%ecx
8010059f:	8d 75 d7             	lea    -0x29(%ebp),%esi
801005a2:	eb 06                	jmp    801005aa <printint+0x2a>
801005a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
801005a8:	89 f9                	mov    %edi,%ecx
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 79 01             	lea    0x1(%ecx),%edi
801005af:	f7 f3                	div    %ebx
801005b1:	0f b6 92 b0 71 10 80 	movzbl -0x7fef8e50(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005ba:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>
  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
801005cb:	8d 79 02             	lea    0x2(%ecx),%edi
801005ce:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i]);
801005d8:	0f be 03             	movsbl (%ebx),%eax
801005db:	83 eb 01             	sub    $0x1,%ebx
801005de:	e8 2d fe ff ff       	call   80100410 <consputc>
  while(--i >= 0)
801005e3:	39 f3                	cmp    %esi,%ebx
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
801005ef:	90                   	nop
    x = -xx;
801005f0:	f7 d8                	neg    %eax
801005f2:	eb a9                	jmp    8010059d <printint+0x1d>
801005f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100600 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
80100609:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060c:	ff 75 08             	pushl  0x8(%ebp)
8010060f:	e8 5c 11 00 00       	call   80101770 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010061b:	e8 70 3e 00 00       	call   80104490 <acquire>
  for(i = 0; i < n; i++)
80100620:	83 c4 10             	add    $0x10,%esp
80100623:	85 f6                	test   %esi,%esi
80100625:	7e 18                	jle    8010063f <consolewrite+0x3f>
80100627:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010062a:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 d5 fd ff ff       	call   80100410 <consputc>
  for(i = 0; i < n; i++)
8010063b:	39 fb                	cmp    %edi,%ebx
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 20 a5 10 80       	push   $0x8010a520
80100647:	e8 64 3f 00 00       	call   801045b0 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 3b 10 00 00       	call   80101690 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100669:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100670:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(locking)
80100673:	0f 85 6f 01 00 00    	jne    801007e8 <cprintf+0x188>
  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c7                	mov    %eax,%edi
80100680:	0f 84 77 01 00 00    	je     801007fd <cprintf+0x19d>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100689:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010068c:	31 db                	xor    %ebx,%ebx
  argp = (uint*)(void*)(&fmt + 1);
8010068e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100691:	85 c0                	test   %eax,%eax
80100693:	75 56                	jne    801006eb <cprintf+0x8b>
80100695:	eb 79                	jmp    80100710 <cprintf+0xb0>
80100697:	89 f6                	mov    %esi,%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[++i] & 0xff;
801006a0:	0f b6 16             	movzbl (%esi),%edx
    if(c == 0)
801006a3:	85 d2                	test   %edx,%edx
801006a5:	74 69                	je     80100710 <cprintf+0xb0>
801006a7:	83 c3 02             	add    $0x2,%ebx
    switch(c){
801006aa:	83 fa 70             	cmp    $0x70,%edx
801006ad:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
801006b0:	0f 84 84 00 00 00    	je     8010073a <cprintf+0xda>
801006b6:	7f 78                	jg     80100730 <cprintf+0xd0>
801006b8:	83 fa 25             	cmp    $0x25,%edx
801006bb:	0f 84 ff 00 00 00    	je     801007c0 <cprintf+0x160>
801006c1:	83 fa 64             	cmp    $0x64,%edx
801006c4:	0f 85 8e 00 00 00    	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 10, 1);
801006ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801006cd:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d2:	8d 48 04             	lea    0x4(%eax),%ecx
801006d5:	8b 00                	mov    (%eax),%eax
801006d7:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801006da:	b9 01 00 00 00       	mov    $0x1,%ecx
801006df:	e8 9c fe ff ff       	call   80100580 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e4:	0f b6 06             	movzbl (%esi),%eax
801006e7:	85 c0                	test   %eax,%eax
801006e9:	74 25                	je     80100710 <cprintf+0xb0>
801006eb:	8d 53 01             	lea    0x1(%ebx),%edx
    if(c != '%'){
801006ee:	83 f8 25             	cmp    $0x25,%eax
801006f1:	8d 34 17             	lea    (%edi,%edx,1),%esi
801006f4:	74 aa                	je     801006a0 <cprintf+0x40>
801006f6:	89 55 e0             	mov    %edx,-0x20(%ebp)
      consputc(c);
801006f9:	e8 12 fd ff ff       	call   80100410 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fe:	0f b6 06             	movzbl (%esi),%eax
      continue;
80100701:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100704:	89 d3                	mov    %edx,%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100706:	85 c0                	test   %eax,%eax
80100708:	75 e1                	jne    801006eb <cprintf+0x8b>
8010070a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(locking)
80100710:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100713:	85 c0                	test   %eax,%eax
80100715:	74 10                	je     80100727 <cprintf+0xc7>
    release(&cons.lock);
80100717:	83 ec 0c             	sub    $0xc,%esp
8010071a:	68 20 a5 10 80       	push   $0x8010a520
8010071f:	e8 8c 3e 00 00       	call   801045b0 <release>
80100724:	83 c4 10             	add    $0x10,%esp
}
80100727:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010072a:	5b                   	pop    %ebx
8010072b:	5e                   	pop    %esi
8010072c:	5f                   	pop    %edi
8010072d:	5d                   	pop    %ebp
8010072e:	c3                   	ret    
8010072f:	90                   	nop
    switch(c){
80100730:	83 fa 73             	cmp    $0x73,%edx
80100733:	74 43                	je     80100778 <cprintf+0x118>
80100735:	83 fa 78             	cmp    $0x78,%edx
80100738:	75 1e                	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 16, 0);
8010073a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010073d:	ba 10 00 00 00       	mov    $0x10,%edx
80100742:	8d 48 04             	lea    0x4(%eax),%ecx
80100745:	8b 00                	mov    (%eax),%eax
80100747:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010074a:	31 c9                	xor    %ecx,%ecx
8010074c:	e8 2f fe ff ff       	call   80100580 <printint>
      break;
80100751:	eb 91                	jmp    801006e4 <cprintf+0x84>
80100753:	90                   	nop
80100754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100758:	b8 25 00 00 00       	mov    $0x25,%eax
8010075d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100760:	e8 ab fc ff ff       	call   80100410 <consputc>
      consputc(c);
80100765:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100768:	89 d0                	mov    %edx,%eax
8010076a:	e8 a1 fc ff ff       	call   80100410 <consputc>
      break;
8010076f:	e9 70 ff ff ff       	jmp    801006e4 <cprintf+0x84>
80100774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((s = (char*)*argp++) == 0)
80100778:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010077b:	8b 10                	mov    (%eax),%edx
8010077d:	8d 48 04             	lea    0x4(%eax),%ecx
80100780:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100783:	85 d2                	test   %edx,%edx
80100785:	74 49                	je     801007d0 <cprintf+0x170>
      for(; *s; s++)
80100787:	0f be 02             	movsbl (%edx),%eax
      if((s = (char*)*argp++) == 0)
8010078a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      for(; *s; s++)
8010078d:	84 c0                	test   %al,%al
8010078f:	0f 84 4f ff ff ff    	je     801006e4 <cprintf+0x84>
80100795:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100798:	89 d3                	mov    %edx,%ebx
8010079a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801007a0:	83 c3 01             	add    $0x1,%ebx
        consputc(*s);
801007a3:	e8 68 fc ff ff       	call   80100410 <consputc>
      for(; *s; s++)
801007a8:	0f be 03             	movsbl (%ebx),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
      if((s = (char*)*argp++) == 0)
801007af:	8b 45 e0             	mov    -0x20(%ebp),%eax
801007b2:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801007b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801007b8:	e9 27 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007bd:	8d 76 00             	lea    0x0(%esi),%esi
      consputc('%');
801007c0:	b8 25 00 00 00       	mov    $0x25,%eax
801007c5:	e8 46 fc ff ff       	call   80100410 <consputc>
      break;
801007ca:	e9 15 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007cf:	90                   	nop
        s = "(null)";
801007d0:	ba 98 71 10 80       	mov    $0x80107198,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 a5 10 80       	push   $0x8010a520
801007f0:	e8 9b 3c 00 00       	call   80104490 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 9f 71 10 80       	push   $0x8010719f
80100805:	e8 86 fb ff ff       	call   80100390 <panic>
8010080a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100810 <consoleintr>:
{
80100810:	55                   	push   %ebp
80100811:	89 e5                	mov    %esp,%ebp
80100813:	57                   	push   %edi
80100814:	56                   	push   %esi
80100815:	53                   	push   %ebx
  int c, doprocdump = 0;
80100816:	31 f6                	xor    %esi,%esi
{
80100818:	83 ec 18             	sub    $0x18,%esp
8010081b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
8010081e:	68 20 a5 10 80       	push   $0x8010a520
80100823:	e8 68 3c 00 00       	call   80104490 <acquire>
  while((c = getc()) >= 0){
80100828:	83 c4 10             	add    $0x10,%esp
8010082b:	90                   	nop
8010082c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100830:	ff d3                	call   *%ebx
80100832:	85 c0                	test   %eax,%eax
80100834:	89 c7                	mov    %eax,%edi
80100836:	78 48                	js     80100880 <consoleintr+0x70>
    switch(c){
80100838:	83 ff 10             	cmp    $0x10,%edi
8010083b:	0f 84 e7 00 00 00    	je     80100928 <consoleintr+0x118>
80100841:	7e 5d                	jle    801008a0 <consoleintr+0x90>
80100843:	83 ff 15             	cmp    $0x15,%edi
80100846:	0f 84 ec 00 00 00    	je     80100938 <consoleintr+0x128>
8010084c:	83 ff 7f             	cmp    $0x7f,%edi
8010084f:	75 54                	jne    801008a5 <consoleintr+0x95>
      if(input.e != input.w){
80100851:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100856:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010085c:	74 d2                	je     80100830 <consoleintr+0x20>
        input.e--;
8010085e:	83 e8 01             	sub    $0x1,%eax
80100861:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100866:	b8 00 01 00 00       	mov    $0x100,%eax
8010086b:	e8 a0 fb ff ff       	call   80100410 <consputc>
  while((c = getc()) >= 0){
80100870:	ff d3                	call   *%ebx
80100872:	85 c0                	test   %eax,%eax
80100874:	89 c7                	mov    %eax,%edi
80100876:	79 c0                	jns    80100838 <consoleintr+0x28>
80100878:	90                   	nop
80100879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100880:	83 ec 0c             	sub    $0xc,%esp
80100883:	68 20 a5 10 80       	push   $0x8010a520
80100888:	e8 23 3d 00 00       	call   801045b0 <release>
  if(doprocdump) {
8010088d:	83 c4 10             	add    $0x10,%esp
80100890:	85 f6                	test   %esi,%esi
80100892:	0f 85 f8 00 00 00    	jne    80100990 <consoleintr+0x180>
}
80100898:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010089b:	5b                   	pop    %ebx
8010089c:	5e                   	pop    %esi
8010089d:	5f                   	pop    %edi
8010089e:	5d                   	pop    %ebp
8010089f:	c3                   	ret    
    switch(c){
801008a0:	83 ff 08             	cmp    $0x8,%edi
801008a3:	74 ac                	je     80100851 <consoleintr+0x41>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008a5:	85 ff                	test   %edi,%edi
801008a7:	74 87                	je     80100830 <consoleintr+0x20>
801008a9:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801008ae:	89 c2                	mov    %eax,%edx
801008b0:	2b 15 a0 ff 10 80    	sub    0x8010ffa0,%edx
801008b6:	83 fa 7f             	cmp    $0x7f,%edx
801008b9:	0f 87 71 ff ff ff    	ja     80100830 <consoleintr+0x20>
801008bf:	8d 50 01             	lea    0x1(%eax),%edx
801008c2:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801008c5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008c8:	89 15 a8 ff 10 80    	mov    %edx,0x8010ffa8
        c = (c == '\r') ? '\n' : c;
801008ce:	0f 84 cc 00 00 00    	je     801009a0 <consoleintr+0x190>
        input.buf[input.e++ % INPUT_BUF] = c;
801008d4:	89 f9                	mov    %edi,%ecx
801008d6:	88 88 20 ff 10 80    	mov    %cl,-0x7fef00e0(%eax)
        consputc(c);
801008dc:	89 f8                	mov    %edi,%eax
801008de:	e8 2d fb ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e3:	83 ff 0a             	cmp    $0xa,%edi
801008e6:	0f 84 c5 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008ec:	83 ff 04             	cmp    $0x4,%edi
801008ef:	0f 84 bc 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008f5:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801008fa:	83 e8 80             	sub    $0xffffff80,%eax
801008fd:	39 05 a8 ff 10 80    	cmp    %eax,0x8010ffa8
80100903:	0f 85 27 ff ff ff    	jne    80100830 <consoleintr+0x20>
          wakeup(&input.r);
80100909:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
8010090c:	a3 a4 ff 10 80       	mov    %eax,0x8010ffa4
          wakeup(&input.r);
80100911:	68 a0 ff 10 80       	push   $0x8010ffa0
80100916:	e8 55 36 00 00       	call   80103f70 <wakeup>
8010091b:	83 c4 10             	add    $0x10,%esp
8010091e:	e9 0d ff ff ff       	jmp    80100830 <consoleintr+0x20>
80100923:	90                   	nop
80100924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
80100928:	be 01 00 00 00       	mov    $0x1,%esi
8010092d:	e9 fe fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100938:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010093d:	39 05 a4 ff 10 80    	cmp    %eax,0x8010ffa4
80100943:	75 2b                	jne    80100970 <consoleintr+0x160>
80100945:	e9 e6 fe ff ff       	jmp    80100830 <consoleintr+0x20>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100950:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100955:	b8 00 01 00 00       	mov    $0x100,%eax
8010095a:	e8 b1 fa ff ff       	call   80100410 <consputc>
      while(input.e != input.w &&
8010095f:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100964:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010096a:	0f 84 c0 fe ff ff    	je     80100830 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100970:	83 e8 01             	sub    $0x1,%eax
80100973:	89 c2                	mov    %eax,%edx
80100975:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100978:	80 ba 20 ff 10 80 0a 	cmpb   $0xa,-0x7fef00e0(%edx)
8010097f:	75 cf                	jne    80100950 <consoleintr+0x140>
80100981:	e9 aa fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100986:	8d 76 00             	lea    0x0(%esi),%esi
80100989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80100990:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100993:	5b                   	pop    %ebx
80100994:	5e                   	pop    %esi
80100995:	5f                   	pop    %edi
80100996:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100997:	e9 b4 36 00 00       	jmp    80104050 <procdump>
8010099c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
801009a0:	c6 80 20 ff 10 80 0a 	movb   $0xa,-0x7fef00e0(%eax)
        consputc(c);
801009a7:	b8 0a 00 00 00       	mov    $0xa,%eax
801009ac:	e8 5f fa ff ff       	call   80100410 <consputc>
801009b1:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801009b6:	e9 4e ff ff ff       	jmp    80100909 <consoleintr+0xf9>
801009bb:	90                   	nop
801009bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801009c0 <consoleinit>:

void
consoleinit(void)
{
801009c0:	55                   	push   %ebp
801009c1:	89 e5                	mov    %esp,%ebp
801009c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009c6:	68 a8 71 10 80       	push   $0x801071a8
801009cb:	68 20 a5 10 80       	push   $0x8010a520
801009d0:	e8 cb 39 00 00       	call   801043a0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009d5:	58                   	pop    %eax
801009d6:	5a                   	pop    %edx
801009d7:	6a 00                	push   $0x0
801009d9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
801009db:	c7 05 6c 09 11 80 00 	movl   $0x80100600,0x8011096c
801009e2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009e5:	c7 05 68 09 11 80 70 	movl   $0x80100270,0x80110968
801009ec:	02 10 80 
  cons.locking = 1;
801009ef:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
801009f6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
801009f9:	e8 e2 18 00 00       	call   801022e0 <ioapicenable>
}
801009fe:	83 c4 10             	add    $0x10,%esp
80100a01:	c9                   	leave  
80100a02:	c3                   	ret    
80100a03:	66 90                	xchg   %ax,%ax
80100a05:	66 90                	xchg   %ax,%ax
80100a07:	66 90                	xchg   %ax,%ax
80100a09:	66 90                	xchg   %ax,%ax
80100a0b:	66 90                	xchg   %ax,%ax
80100a0d:	66 90                	xchg   %ax,%ax
80100a0f:	90                   	nop

80100a10 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100a10:	55                   	push   %ebp
80100a11:	89 e5                	mov    %esp,%ebp
80100a13:	57                   	push   %edi
80100a14:	56                   	push   %esi
80100a15:	53                   	push   %ebx
80100a16:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a1c:	e8 df 2d 00 00       	call   80103800 <myproc>
80100a21:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100a27:	e8 84 21 00 00       	call   80102bb0 <begin_op>

  if((ip = namei(path)) == 0){
80100a2c:	83 ec 0c             	sub    $0xc,%esp
80100a2f:	ff 75 08             	pushl  0x8(%ebp)
80100a32:	e8 b9 14 00 00       	call   80101ef0 <namei>
80100a37:	83 c4 10             	add    $0x10,%esp
80100a3a:	85 c0                	test   %eax,%eax
80100a3c:	0f 84 91 01 00 00    	je     80100bd3 <exec+0x1c3>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a42:	83 ec 0c             	sub    $0xc,%esp
80100a45:	89 c3                	mov    %eax,%ebx
80100a47:	50                   	push   %eax
80100a48:	e8 43 0c 00 00       	call   80101690 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a4d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a53:	6a 34                	push   $0x34
80100a55:	6a 00                	push   $0x0
80100a57:	50                   	push   %eax
80100a58:	53                   	push   %ebx
80100a59:	e8 12 0f 00 00       	call   80101970 <readi>
80100a5e:	83 c4 20             	add    $0x20,%esp
80100a61:	83 f8 34             	cmp    $0x34,%eax
80100a64:	74 22                	je     80100a88 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a66:	83 ec 0c             	sub    $0xc,%esp
80100a69:	53                   	push   %ebx
80100a6a:	e8 b1 0e 00 00       	call   80101920 <iunlockput>
    end_op();
80100a6f:	e8 ac 21 00 00       	call   80102c20 <end_op>
80100a74:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a77:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a7f:	5b                   	pop    %ebx
80100a80:	5e                   	pop    %esi
80100a81:	5f                   	pop    %edi
80100a82:	5d                   	pop    %ebp
80100a83:	c3                   	ret    
80100a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100a88:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a8f:	45 4c 46 
80100a92:	75 d2                	jne    80100a66 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100a94:	e8 17 64 00 00       	call   80106eb0 <setupkvm>
80100a99:	85 c0                	test   %eax,%eax
80100a9b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100aa1:	74 c3                	je     80100a66 <exec+0x56>
  sz = 0;
80100aa3:	31 ff                	xor    %edi,%edi
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100aa5:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100aac:	00 
80100aad:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100ab3:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100ab9:	0f 84 93 02 00 00    	je     80100d52 <exec+0x342>
80100abf:	31 f6                	xor    %esi,%esi
80100ac1:	eb 7f                	jmp    80100b42 <exec+0x132>
80100ac3:	90                   	nop
80100ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100ac8:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100acf:	75 63                	jne    80100b34 <exec+0x124>
    if(ph.memsz < ph.filesz)
80100ad1:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100ad7:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100add:	0f 82 86 00 00 00    	jb     80100b69 <exec+0x159>
80100ae3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ae9:	72 7e                	jb     80100b69 <exec+0x159>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100aeb:	83 ec 04             	sub    $0x4,%esp
80100aee:	50                   	push   %eax
80100aef:	57                   	push   %edi
80100af0:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100af6:	e8 d5 61 00 00       	call   80106cd0 <allocuvm>
80100afb:	83 c4 10             	add    $0x10,%esp
80100afe:	85 c0                	test   %eax,%eax
80100b00:	89 c7                	mov    %eax,%edi
80100b02:	74 65                	je     80100b69 <exec+0x159>
    if(ph.vaddr % PGSIZE != 0)
80100b04:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b0a:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b0f:	75 58                	jne    80100b69 <exec+0x159>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b11:	83 ec 0c             	sub    $0xc,%esp
80100b14:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b1a:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b20:	53                   	push   %ebx
80100b21:	50                   	push   %eax
80100b22:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b28:	e8 e3 60 00 00       	call   80106c10 <loaduvm>
80100b2d:	83 c4 20             	add    $0x20,%esp
80100b30:	85 c0                	test   %eax,%eax
80100b32:	78 35                	js     80100b69 <exec+0x159>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b34:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100b3b:	83 c6 01             	add    $0x1,%esi
80100b3e:	39 f0                	cmp    %esi,%eax
80100b40:	7e 3d                	jle    80100b7f <exec+0x16f>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b42:	89 f0                	mov    %esi,%eax
80100b44:	6a 20                	push   $0x20
80100b46:	c1 e0 05             	shl    $0x5,%eax
80100b49:	03 85 ec fe ff ff    	add    -0x114(%ebp),%eax
80100b4f:	50                   	push   %eax
80100b50:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100b56:	50                   	push   %eax
80100b57:	53                   	push   %ebx
80100b58:	e8 13 0e 00 00       	call   80101970 <readi>
80100b5d:	83 c4 10             	add    $0x10,%esp
80100b60:	83 f8 20             	cmp    $0x20,%eax
80100b63:	0f 84 5f ff ff ff    	je     80100ac8 <exec+0xb8>
    freevm(pgdir);
80100b69:	83 ec 0c             	sub    $0xc,%esp
80100b6c:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b72:	e8 b9 62 00 00       	call   80106e30 <freevm>
80100b77:	83 c4 10             	add    $0x10,%esp
80100b7a:	e9 e7 fe ff ff       	jmp    80100a66 <exec+0x56>
80100b7f:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100b85:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100b8b:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100b91:	83 ec 0c             	sub    $0xc,%esp
80100b94:	53                   	push   %ebx
80100b95:	e8 86 0d 00 00       	call   80101920 <iunlockput>
  end_op();
80100b9a:	e8 81 20 00 00       	call   80102c20 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b9f:	83 c4 0c             	add    $0xc,%esp
80100ba2:	56                   	push   %esi
80100ba3:	57                   	push   %edi
80100ba4:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100baa:	e8 21 61 00 00       	call   80106cd0 <allocuvm>
80100baf:	83 c4 10             	add    $0x10,%esp
80100bb2:	85 c0                	test   %eax,%eax
80100bb4:	89 c6                	mov    %eax,%esi
80100bb6:	75 3a                	jne    80100bf2 <exec+0x1e2>
    freevm(pgdir);
80100bb8:	83 ec 0c             	sub    $0xc,%esp
80100bbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bc1:	e8 6a 62 00 00       	call   80106e30 <freevm>
80100bc6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100bc9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bce:	e9 a9 fe ff ff       	jmp    80100a7c <exec+0x6c>
    end_op();
80100bd3:	e8 48 20 00 00       	call   80102c20 <end_op>
    cprintf("exec: fail\n");
80100bd8:	83 ec 0c             	sub    $0xc,%esp
80100bdb:	68 c1 71 10 80       	push   $0x801071c1
80100be0:	e8 7b fa ff ff       	call   80100660 <cprintf>
    return -1;
80100be5:	83 c4 10             	add    $0x10,%esp
80100be8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bed:	e9 8a fe ff ff       	jmp    80100a7c <exec+0x6c>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bf2:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100bf8:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100bfb:	31 ff                	xor    %edi,%edi
80100bfd:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bff:	50                   	push   %eax
80100c00:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c06:	e8 45 63 00 00       	call   80106f50 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c0b:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c0e:	83 c4 10             	add    $0x10,%esp
80100c11:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c17:	8b 00                	mov    (%eax),%eax
80100c19:	85 c0                	test   %eax,%eax
80100c1b:	74 70                	je     80100c8d <exec+0x27d>
80100c1d:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100c23:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c29:	eb 0a                	jmp    80100c35 <exec+0x225>
80100c2b:	90                   	nop
80100c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(argc >= MAXARG)
80100c30:	83 ff 20             	cmp    $0x20,%edi
80100c33:	74 83                	je     80100bb8 <exec+0x1a8>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c35:	83 ec 0c             	sub    $0xc,%esp
80100c38:	50                   	push   %eax
80100c39:	e8 12 3c 00 00       	call   80104850 <strlen>
80100c3e:	f7 d0                	not    %eax
80100c40:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c42:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c45:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c46:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c49:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4c:	e8 ff 3b 00 00       	call   80104850 <strlen>
80100c51:	83 c0 01             	add    $0x1,%eax
80100c54:	50                   	push   %eax
80100c55:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c58:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c5b:	53                   	push   %ebx
80100c5c:	56                   	push   %esi
80100c5d:	e8 3e 64 00 00       	call   801070a0 <copyout>
80100c62:	83 c4 20             	add    $0x20,%esp
80100c65:	85 c0                	test   %eax,%eax
80100c67:	0f 88 4b ff ff ff    	js     80100bb8 <exec+0x1a8>
  for(argc = 0; argv[argc]; argc++) {
80100c6d:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c70:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c77:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100c7a:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100c80:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c83:	85 c0                	test   %eax,%eax
80100c85:	75 a9                	jne    80100c30 <exec+0x220>
80100c87:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c8d:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c94:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100c96:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100c9d:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100ca1:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100ca8:	ff ff ff 
  ustack[1] = argc;
80100cab:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cb1:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100cb3:	83 c0 0c             	add    $0xc,%eax
80100cb6:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cb8:	50                   	push   %eax
80100cb9:	52                   	push   %edx
80100cba:	53                   	push   %ebx
80100cbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cc1:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cc7:	e8 d4 63 00 00       	call   801070a0 <copyout>
80100ccc:	83 c4 10             	add    $0x10,%esp
80100ccf:	85 c0                	test   %eax,%eax
80100cd1:	0f 88 e1 fe ff ff    	js     80100bb8 <exec+0x1a8>
  for(last=s=path; *s; s++)
80100cd7:	8b 45 08             	mov    0x8(%ebp),%eax
80100cda:	0f b6 00             	movzbl (%eax),%eax
80100cdd:	84 c0                	test   %al,%al
80100cdf:	74 17                	je     80100cf8 <exec+0x2e8>
80100ce1:	8b 55 08             	mov    0x8(%ebp),%edx
80100ce4:	89 d1                	mov    %edx,%ecx
80100ce6:	83 c1 01             	add    $0x1,%ecx
80100ce9:	3c 2f                	cmp    $0x2f,%al
80100ceb:	0f b6 01             	movzbl (%ecx),%eax
80100cee:	0f 44 d1             	cmove  %ecx,%edx
80100cf1:	84 c0                	test   %al,%al
80100cf3:	75 f1                	jne    80100ce6 <exec+0x2d6>
80100cf5:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cf8:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cfe:	50                   	push   %eax
80100cff:	6a 10                	push   $0x10
80100d01:	ff 75 08             	pushl  0x8(%ebp)
80100d04:	89 f8                	mov    %edi,%eax
80100d06:	83 c0 6c             	add    $0x6c,%eax
80100d09:	50                   	push   %eax
80100d0a:	e8 01 3b 00 00       	call   80104810 <safestrcpy>
  curproc->pgdir = pgdir;
80100d0f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  oldpgdir = curproc->pgdir;
80100d15:	89 f9                	mov    %edi,%ecx
80100d17:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->tf->eip = elf.entry;  // main
80100d1a:	8b 41 18             	mov    0x18(%ecx),%eax
  curproc->sz = sz;
80100d1d:	89 31                	mov    %esi,(%ecx)
  curproc->pgdir = pgdir;
80100d1f:	89 51 04             	mov    %edx,0x4(%ecx)
  curproc->tf->eip = elf.entry;  // main
80100d22:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d28:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d2b:	8b 41 18             	mov    0x18(%ecx),%eax
80100d2e:	89 58 44             	mov    %ebx,0x44(%eax)
  curproc->priority = 2; // Add priority to newly created process
80100d31:	c7 41 7c 02 00 00 00 	movl   $0x2,0x7c(%ecx)
  switchuvm(curproc);
80100d38:	89 0c 24             	mov    %ecx,(%esp)
80100d3b:	e8 40 5d 00 00       	call   80106a80 <switchuvm>
  freevm(oldpgdir);
80100d40:	89 3c 24             	mov    %edi,(%esp)
80100d43:	e8 e8 60 00 00       	call   80106e30 <freevm>
  return 0;
80100d48:	83 c4 10             	add    $0x10,%esp
80100d4b:	31 c0                	xor    %eax,%eax
80100d4d:	e9 2a fd ff ff       	jmp    80100a7c <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d52:	be 00 20 00 00       	mov    $0x2000,%esi
80100d57:	e9 35 fe ff ff       	jmp    80100b91 <exec+0x181>
80100d5c:	66 90                	xchg   %ax,%ax
80100d5e:	66 90                	xchg   %ax,%ax

80100d60 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d60:	55                   	push   %ebp
80100d61:	89 e5                	mov    %esp,%ebp
80100d63:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d66:	68 cd 71 10 80       	push   $0x801071cd
80100d6b:	68 c0 ff 10 80       	push   $0x8010ffc0
80100d70:	e8 2b 36 00 00       	call   801043a0 <initlock>
}
80100d75:	83 c4 10             	add    $0x10,%esp
80100d78:	c9                   	leave  
80100d79:	c3                   	ret    
80100d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d80 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d80:	55                   	push   %ebp
80100d81:	89 e5                	mov    %esp,%ebp
80100d83:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d84:	bb f4 ff 10 80       	mov    $0x8010fff4,%ebx
{
80100d89:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100d8c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100d91:	e8 fa 36 00 00       	call   80104490 <acquire>
80100d96:	83 c4 10             	add    $0x10,%esp
80100d99:	eb 10                	jmp    80100dab <filealloc+0x2b>
80100d9b:	90                   	nop
80100d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100da0:	83 c3 18             	add    $0x18,%ebx
80100da3:	81 fb 54 09 11 80    	cmp    $0x80110954,%ebx
80100da9:	73 25                	jae    80100dd0 <filealloc+0x50>
    if(f->ref == 0){
80100dab:	8b 43 04             	mov    0x4(%ebx),%eax
80100dae:	85 c0                	test   %eax,%eax
80100db0:	75 ee                	jne    80100da0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100db2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100db5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100dbc:	68 c0 ff 10 80       	push   $0x8010ffc0
80100dc1:	e8 ea 37 00 00       	call   801045b0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100dc6:	89 d8                	mov    %ebx,%eax
      return f;
80100dc8:	83 c4 10             	add    $0x10,%esp
}
80100dcb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dce:	c9                   	leave  
80100dcf:	c3                   	ret    
  release(&ftable.lock);
80100dd0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100dd3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100dd5:	68 c0 ff 10 80       	push   $0x8010ffc0
80100dda:	e8 d1 37 00 00       	call   801045b0 <release>
}
80100ddf:	89 d8                	mov    %ebx,%eax
  return 0;
80100de1:	83 c4 10             	add    $0x10,%esp
}
80100de4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100de7:	c9                   	leave  
80100de8:	c3                   	ret    
80100de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100df0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100df0:	55                   	push   %ebp
80100df1:	89 e5                	mov    %esp,%ebp
80100df3:	53                   	push   %ebx
80100df4:	83 ec 10             	sub    $0x10,%esp
80100df7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dfa:	68 c0 ff 10 80       	push   $0x8010ffc0
80100dff:	e8 8c 36 00 00       	call   80104490 <acquire>
  if(f->ref < 1)
80100e04:	8b 43 04             	mov    0x4(%ebx),%eax
80100e07:	83 c4 10             	add    $0x10,%esp
80100e0a:	85 c0                	test   %eax,%eax
80100e0c:	7e 1a                	jle    80100e28 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100e0e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e11:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100e14:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e17:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e1c:	e8 8f 37 00 00       	call   801045b0 <release>
  return f;
}
80100e21:	89 d8                	mov    %ebx,%eax
80100e23:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e26:	c9                   	leave  
80100e27:	c3                   	ret    
    panic("filedup");
80100e28:	83 ec 0c             	sub    $0xc,%esp
80100e2b:	68 d4 71 10 80       	push   $0x801071d4
80100e30:	e8 5b f5 ff ff       	call   80100390 <panic>
80100e35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e40 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e40:	55                   	push   %ebp
80100e41:	89 e5                	mov    %esp,%ebp
80100e43:	57                   	push   %edi
80100e44:	56                   	push   %esi
80100e45:	53                   	push   %ebx
80100e46:	83 ec 28             	sub    $0x28,%esp
80100e49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100e4c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e51:	e8 3a 36 00 00       	call   80104490 <acquire>
  if(f->ref < 1)
80100e56:	8b 43 04             	mov    0x4(%ebx),%eax
80100e59:	83 c4 10             	add    $0x10,%esp
80100e5c:	85 c0                	test   %eax,%eax
80100e5e:	0f 8e 9b 00 00 00    	jle    80100eff <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100e64:	83 e8 01             	sub    $0x1,%eax
80100e67:	85 c0                	test   %eax,%eax
80100e69:	89 43 04             	mov    %eax,0x4(%ebx)
80100e6c:	74 1a                	je     80100e88 <fileclose+0x48>
    release(&ftable.lock);
80100e6e:	c7 45 08 c0 ff 10 80 	movl   $0x8010ffc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e75:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e78:	5b                   	pop    %ebx
80100e79:	5e                   	pop    %esi
80100e7a:	5f                   	pop    %edi
80100e7b:	5d                   	pop    %ebp
    release(&ftable.lock);
80100e7c:	e9 2f 37 00 00       	jmp    801045b0 <release>
80100e81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100e88:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100e8c:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
80100e8e:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100e91:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100e94:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100e9a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e9d:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100ea0:	68 c0 ff 10 80       	push   $0x8010ffc0
  ff = *f;
80100ea5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100ea8:	e8 03 37 00 00       	call   801045b0 <release>
  if(ff.type == FD_PIPE)
80100ead:	83 c4 10             	add    $0x10,%esp
80100eb0:	83 ff 01             	cmp    $0x1,%edi
80100eb3:	74 13                	je     80100ec8 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80100eb5:	83 ff 02             	cmp    $0x2,%edi
80100eb8:	74 26                	je     80100ee0 <fileclose+0xa0>
}
80100eba:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ebd:	5b                   	pop    %ebx
80100ebe:	5e                   	pop    %esi
80100ebf:	5f                   	pop    %edi
80100ec0:	5d                   	pop    %ebp
80100ec1:	c3                   	ret    
80100ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80100ec8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100ecc:	83 ec 08             	sub    $0x8,%esp
80100ecf:	53                   	push   %ebx
80100ed0:	56                   	push   %esi
80100ed1:	e8 8a 24 00 00       	call   80103360 <pipeclose>
80100ed6:	83 c4 10             	add    $0x10,%esp
80100ed9:	eb df                	jmp    80100eba <fileclose+0x7a>
80100edb:	90                   	nop
80100edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100ee0:	e8 cb 1c 00 00       	call   80102bb0 <begin_op>
    iput(ff.ip);
80100ee5:	83 ec 0c             	sub    $0xc,%esp
80100ee8:	ff 75 e0             	pushl  -0x20(%ebp)
80100eeb:	e8 d0 08 00 00       	call   801017c0 <iput>
    end_op();
80100ef0:	83 c4 10             	add    $0x10,%esp
}
80100ef3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ef6:	5b                   	pop    %ebx
80100ef7:	5e                   	pop    %esi
80100ef8:	5f                   	pop    %edi
80100ef9:	5d                   	pop    %ebp
    end_op();
80100efa:	e9 21 1d 00 00       	jmp    80102c20 <end_op>
    panic("fileclose");
80100eff:	83 ec 0c             	sub    $0xc,%esp
80100f02:	68 dc 71 10 80       	push   $0x801071dc
80100f07:	e8 84 f4 ff ff       	call   80100390 <panic>
80100f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f10 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f10:	55                   	push   %ebp
80100f11:	89 e5                	mov    %esp,%ebp
80100f13:	53                   	push   %ebx
80100f14:	83 ec 04             	sub    $0x4,%esp
80100f17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f1a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f1d:	75 31                	jne    80100f50 <filestat+0x40>
    ilock(f->ip);
80100f1f:	83 ec 0c             	sub    $0xc,%esp
80100f22:	ff 73 10             	pushl  0x10(%ebx)
80100f25:	e8 66 07 00 00       	call   80101690 <ilock>
    stati(f->ip, st);
80100f2a:	58                   	pop    %eax
80100f2b:	5a                   	pop    %edx
80100f2c:	ff 75 0c             	pushl  0xc(%ebp)
80100f2f:	ff 73 10             	pushl  0x10(%ebx)
80100f32:	e8 09 0a 00 00       	call   80101940 <stati>
    iunlock(f->ip);
80100f37:	59                   	pop    %ecx
80100f38:	ff 73 10             	pushl  0x10(%ebx)
80100f3b:	e8 30 08 00 00       	call   80101770 <iunlock>
    return 0;
80100f40:	83 c4 10             	add    $0x10,%esp
80100f43:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f48:	c9                   	leave  
80100f49:	c3                   	ret    
80100f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80100f50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f55:	eb ee                	jmp    80100f45 <filestat+0x35>
80100f57:	89 f6                	mov    %esi,%esi
80100f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f60 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f60:	55                   	push   %ebp
80100f61:	89 e5                	mov    %esp,%ebp
80100f63:	57                   	push   %edi
80100f64:	56                   	push   %esi
80100f65:	53                   	push   %ebx
80100f66:	83 ec 0c             	sub    $0xc,%esp
80100f69:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f6c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f6f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f72:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f76:	74 60                	je     80100fd8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100f78:	8b 03                	mov    (%ebx),%eax
80100f7a:	83 f8 01             	cmp    $0x1,%eax
80100f7d:	74 41                	je     80100fc0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f7f:	83 f8 02             	cmp    $0x2,%eax
80100f82:	75 5b                	jne    80100fdf <fileread+0x7f>
    ilock(f->ip);
80100f84:	83 ec 0c             	sub    $0xc,%esp
80100f87:	ff 73 10             	pushl  0x10(%ebx)
80100f8a:	e8 01 07 00 00       	call   80101690 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f8f:	57                   	push   %edi
80100f90:	ff 73 14             	pushl  0x14(%ebx)
80100f93:	56                   	push   %esi
80100f94:	ff 73 10             	pushl  0x10(%ebx)
80100f97:	e8 d4 09 00 00       	call   80101970 <readi>
80100f9c:	83 c4 20             	add    $0x20,%esp
80100f9f:	85 c0                	test   %eax,%eax
80100fa1:	89 c6                	mov    %eax,%esi
80100fa3:	7e 03                	jle    80100fa8 <fileread+0x48>
      f->off += r;
80100fa5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100fa8:	83 ec 0c             	sub    $0xc,%esp
80100fab:	ff 73 10             	pushl  0x10(%ebx)
80100fae:	e8 bd 07 00 00       	call   80101770 <iunlock>
    return r;
80100fb3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80100fb6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fb9:	89 f0                	mov    %esi,%eax
80100fbb:	5b                   	pop    %ebx
80100fbc:	5e                   	pop    %esi
80100fbd:	5f                   	pop    %edi
80100fbe:	5d                   	pop    %ebp
80100fbf:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80100fc0:	8b 43 0c             	mov    0xc(%ebx),%eax
80100fc3:	89 45 08             	mov    %eax,0x8(%ebp)
}
80100fc6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fc9:	5b                   	pop    %ebx
80100fca:	5e                   	pop    %esi
80100fcb:	5f                   	pop    %edi
80100fcc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80100fcd:	e9 3e 25 00 00       	jmp    80103510 <piperead>
80100fd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80100fd8:	be ff ff ff ff       	mov    $0xffffffff,%esi
80100fdd:	eb d7                	jmp    80100fb6 <fileread+0x56>
  panic("fileread");
80100fdf:	83 ec 0c             	sub    $0xc,%esp
80100fe2:	68 e6 71 10 80       	push   $0x801071e6
80100fe7:	e8 a4 f3 ff ff       	call   80100390 <panic>
80100fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100ff0 <filewrite>:

// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100ff0:	55                   	push   %ebp
80100ff1:	89 e5                	mov    %esp,%ebp
80100ff3:	57                   	push   %edi
80100ff4:	56                   	push   %esi
80100ff5:	53                   	push   %ebx
80100ff6:	83 ec 1c             	sub    $0x1c,%esp
80100ff9:	8b 75 08             	mov    0x8(%ebp),%esi
80100ffc:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
80100fff:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101003:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101006:	8b 45 10             	mov    0x10(%ebp),%eax
80101009:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010100c:	0f 84 aa 00 00 00    	je     801010bc <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101012:	8b 06                	mov    (%esi),%eax
80101014:	83 f8 01             	cmp    $0x1,%eax
80101017:	0f 84 c3 00 00 00    	je     801010e0 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010101d:	83 f8 02             	cmp    $0x2,%eax
80101020:	0f 85 d9 00 00 00    	jne    801010ff <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101026:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101029:	31 ff                	xor    %edi,%edi
    while(i < n){
8010102b:	85 c0                	test   %eax,%eax
8010102d:	7f 34                	jg     80101063 <filewrite+0x73>
8010102f:	e9 9c 00 00 00       	jmp    801010d0 <filewrite+0xe0>
80101034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101038:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010103b:	83 ec 0c             	sub    $0xc,%esp
8010103e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101041:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101044:	e8 27 07 00 00       	call   80101770 <iunlock>
      end_op();
80101049:	e8 d2 1b 00 00       	call   80102c20 <end_op>
8010104e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101051:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101054:	39 c3                	cmp    %eax,%ebx
80101056:	0f 85 96 00 00 00    	jne    801010f2 <filewrite+0x102>
        panic("short filewrite");
      i += r;
8010105c:	01 df                	add    %ebx,%edi
    while(i < n){
8010105e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101061:	7e 6d                	jle    801010d0 <filewrite+0xe0>
      int n1 = n - i;
80101063:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101066:	b8 00 1a 00 00       	mov    $0x1a00,%eax
8010106b:	29 fb                	sub    %edi,%ebx
8010106d:	81 fb 00 1a 00 00    	cmp    $0x1a00,%ebx
80101073:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101076:	e8 35 1b 00 00       	call   80102bb0 <begin_op>
      ilock(f->ip);
8010107b:	83 ec 0c             	sub    $0xc,%esp
8010107e:	ff 76 10             	pushl  0x10(%esi)
80101081:	e8 0a 06 00 00       	call   80101690 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101086:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101089:	53                   	push   %ebx
8010108a:	ff 76 14             	pushl  0x14(%esi)
8010108d:	01 f8                	add    %edi,%eax
8010108f:	50                   	push   %eax
80101090:	ff 76 10             	pushl  0x10(%esi)
80101093:	e8 d8 09 00 00       	call   80101a70 <writei>
80101098:	83 c4 20             	add    $0x20,%esp
8010109b:	85 c0                	test   %eax,%eax
8010109d:	7f 99                	jg     80101038 <filewrite+0x48>
      iunlock(f->ip);
8010109f:	83 ec 0c             	sub    $0xc,%esp
801010a2:	ff 76 10             	pushl  0x10(%esi)
801010a5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010a8:	e8 c3 06 00 00       	call   80101770 <iunlock>
      end_op();
801010ad:	e8 6e 1b 00 00       	call   80102c20 <end_op>
      if(r < 0)
801010b2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010b5:	83 c4 10             	add    $0x10,%esp
801010b8:	85 c0                	test   %eax,%eax
801010ba:	74 98                	je     80101054 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801010bf:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
801010c4:	89 f8                	mov    %edi,%eax
801010c6:	5b                   	pop    %ebx
801010c7:	5e                   	pop    %esi
801010c8:	5f                   	pop    %edi
801010c9:	5d                   	pop    %ebp
801010ca:	c3                   	ret    
801010cb:	90                   	nop
801010cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
801010d0:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801010d3:	75 e7                	jne    801010bc <filewrite+0xcc>
}
801010d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010d8:	89 f8                	mov    %edi,%eax
801010da:	5b                   	pop    %ebx
801010db:	5e                   	pop    %esi
801010dc:	5f                   	pop    %edi
801010dd:	5d                   	pop    %ebp
801010de:	c3                   	ret    
801010df:	90                   	nop
    return pipewrite(f->pipe, addr, n);
801010e0:	8b 46 0c             	mov    0xc(%esi),%eax
801010e3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801010e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010e9:	5b                   	pop    %ebx
801010ea:	5e                   	pop    %esi
801010eb:	5f                   	pop    %edi
801010ec:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801010ed:	e9 0e 23 00 00       	jmp    80103400 <pipewrite>
        panic("short filewrite");
801010f2:	83 ec 0c             	sub    $0xc,%esp
801010f5:	68 ef 71 10 80       	push   $0x801071ef
801010fa:	e8 91 f2 ff ff       	call   80100390 <panic>
  panic("filewrite");
801010ff:	83 ec 0c             	sub    $0xc,%esp
80101102:	68 f5 71 10 80       	push   $0x801071f5
80101107:	e8 84 f2 ff ff       	call   80100390 <panic>
8010110c:	66 90                	xchg   %ax,%ax
8010110e:	66 90                	xchg   %ax,%ax

80101110 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101110:	55                   	push   %ebp
80101111:	89 e5                	mov    %esp,%ebp
80101113:	57                   	push   %edi
80101114:	56                   	push   %esi
80101115:	53                   	push   %ebx
80101116:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101119:	8b 0d c0 09 11 80    	mov    0x801109c0,%ecx
{
8010111f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101122:	85 c9                	test   %ecx,%ecx
80101124:	0f 84 87 00 00 00    	je     801011b1 <balloc+0xa1>
8010112a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101131:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101134:	83 ec 08             	sub    $0x8,%esp
80101137:	89 f0                	mov    %esi,%eax
80101139:	c1 f8 0c             	sar    $0xc,%eax
8010113c:	03 05 d8 09 11 80    	add    0x801109d8,%eax
80101142:	50                   	push   %eax
80101143:	ff 75 d8             	pushl  -0x28(%ebp)
80101146:	e8 85 ef ff ff       	call   801000d0 <bread>
8010114b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010114e:	a1 c0 09 11 80       	mov    0x801109c0,%eax
80101153:	83 c4 10             	add    $0x10,%esp
80101156:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101159:	31 c0                	xor    %eax,%eax
8010115b:	eb 2f                	jmp    8010118c <balloc+0x7c>
8010115d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101160:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101162:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
80101165:	bb 01 00 00 00       	mov    $0x1,%ebx
8010116a:	83 e1 07             	and    $0x7,%ecx
8010116d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010116f:	89 c1                	mov    %eax,%ecx
80101171:	c1 f9 03             	sar    $0x3,%ecx
80101174:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101179:	85 df                	test   %ebx,%edi
8010117b:	89 fa                	mov    %edi,%edx
8010117d:	74 41                	je     801011c0 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010117f:	83 c0 01             	add    $0x1,%eax
80101182:	83 c6 01             	add    $0x1,%esi
80101185:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010118a:	74 05                	je     80101191 <balloc+0x81>
8010118c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010118f:	77 cf                	ja     80101160 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101191:	83 ec 0c             	sub    $0xc,%esp
80101194:	ff 75 e4             	pushl  -0x1c(%ebp)
80101197:	e8 44 f0 ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010119c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801011a3:	83 c4 10             	add    $0x10,%esp
801011a6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011a9:	39 05 c0 09 11 80    	cmp    %eax,0x801109c0
801011af:	77 80                	ja     80101131 <balloc+0x21>
  }
  panic("balloc: out of blocks");
801011b1:	83 ec 0c             	sub    $0xc,%esp
801011b4:	68 ff 71 10 80       	push   $0x801071ff
801011b9:	e8 d2 f1 ff ff       	call   80100390 <panic>
801011be:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
801011c0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801011c3:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801011c6:	09 da                	or     %ebx,%edx
801011c8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801011cc:	57                   	push   %edi
801011cd:	e8 ae 1b 00 00       	call   80102d80 <log_write>
        brelse(bp);
801011d2:	89 3c 24             	mov    %edi,(%esp)
801011d5:	e8 06 f0 ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
801011da:	58                   	pop    %eax
801011db:	5a                   	pop    %edx
801011dc:	56                   	push   %esi
801011dd:	ff 75 d8             	pushl  -0x28(%ebp)
801011e0:	e8 eb ee ff ff       	call   801000d0 <bread>
801011e5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801011e7:	8d 40 5c             	lea    0x5c(%eax),%eax
801011ea:	83 c4 0c             	add    $0xc,%esp
801011ed:	68 00 02 00 00       	push   $0x200
801011f2:	6a 00                	push   $0x0
801011f4:	50                   	push   %eax
801011f5:	e8 16 34 00 00       	call   80104610 <memset>
  log_write(bp);
801011fa:	89 1c 24             	mov    %ebx,(%esp)
801011fd:	e8 7e 1b 00 00       	call   80102d80 <log_write>
  brelse(bp);
80101202:	89 1c 24             	mov    %ebx,(%esp)
80101205:	e8 d6 ef ff ff       	call   801001e0 <brelse>
}
8010120a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010120d:	89 f0                	mov    %esi,%eax
8010120f:	5b                   	pop    %ebx
80101210:	5e                   	pop    %esi
80101211:	5f                   	pop    %edi
80101212:	5d                   	pop    %ebp
80101213:	c3                   	ret    
80101214:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010121a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101220 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101220:	55                   	push   %ebp
80101221:	89 e5                	mov    %esp,%ebp
80101223:	57                   	push   %edi
80101224:	56                   	push   %esi
80101225:	53                   	push   %ebx
80101226:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101228:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010122a:	bb 14 0a 11 80       	mov    $0x80110a14,%ebx
{
8010122f:	83 ec 28             	sub    $0x28,%esp
80101232:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101235:	68 e0 09 11 80       	push   $0x801109e0
8010123a:	e8 51 32 00 00       	call   80104490 <acquire>
8010123f:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101242:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101245:	eb 17                	jmp    8010125e <iget+0x3e>
80101247:	89 f6                	mov    %esi,%esi
80101249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101250:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101256:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
8010125c:	73 22                	jae    80101280 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010125e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101261:	85 c9                	test   %ecx,%ecx
80101263:	7e 04                	jle    80101269 <iget+0x49>
80101265:	39 3b                	cmp    %edi,(%ebx)
80101267:	74 4f                	je     801012b8 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101269:	85 f6                	test   %esi,%esi
8010126b:	75 e3                	jne    80101250 <iget+0x30>
8010126d:	85 c9                	test   %ecx,%ecx
8010126f:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101272:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101278:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
8010127e:	72 de                	jb     8010125e <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101280:	85 f6                	test   %esi,%esi
80101282:	74 5b                	je     801012df <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101284:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101287:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101289:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010128c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101293:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010129a:	68 e0 09 11 80       	push   $0x801109e0
8010129f:	e8 0c 33 00 00       	call   801045b0 <release>

  return ip;
801012a4:	83 c4 10             	add    $0x10,%esp
}
801012a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012aa:	89 f0                	mov    %esi,%eax
801012ac:	5b                   	pop    %ebx
801012ad:	5e                   	pop    %esi
801012ae:	5f                   	pop    %edi
801012af:	5d                   	pop    %ebp
801012b0:	c3                   	ret    
801012b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012b8:	39 53 04             	cmp    %edx,0x4(%ebx)
801012bb:	75 ac                	jne    80101269 <iget+0x49>
      release(&icache.lock);
801012bd:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
801012c0:	83 c1 01             	add    $0x1,%ecx
      return ip;
801012c3:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
801012c5:	68 e0 09 11 80       	push   $0x801109e0
      ip->ref++;
801012ca:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801012cd:	e8 de 32 00 00       	call   801045b0 <release>
      return ip;
801012d2:	83 c4 10             	add    $0x10,%esp
}
801012d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012d8:	89 f0                	mov    %esi,%eax
801012da:	5b                   	pop    %ebx
801012db:	5e                   	pop    %esi
801012dc:	5f                   	pop    %edi
801012dd:	5d                   	pop    %ebp
801012de:	c3                   	ret    
    panic("iget: no inodes");
801012df:	83 ec 0c             	sub    $0xc,%esp
801012e2:	68 15 72 10 80       	push   $0x80107215
801012e7:	e8 a4 f0 ff ff       	call   80100390 <panic>
801012ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801012f0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801012f0:	55                   	push   %ebp
801012f1:	89 e5                	mov    %esp,%ebp
801012f3:	57                   	push   %edi
801012f4:	56                   	push   %esi
801012f5:	53                   	push   %ebx
801012f6:	89 c6                	mov    %eax,%esi
801012f8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801012fb:	83 fa 0b             	cmp    $0xb,%edx
801012fe:	77 18                	ja     80101318 <bmap+0x28>
80101300:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
80101303:	8b 5f 5c             	mov    0x5c(%edi),%ebx
80101306:	85 db                	test   %ebx,%ebx
80101308:	74 76                	je     80101380 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010130a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010130d:	89 d8                	mov    %ebx,%eax
8010130f:	5b                   	pop    %ebx
80101310:	5e                   	pop    %esi
80101311:	5f                   	pop    %edi
80101312:	5d                   	pop    %ebp
80101313:	c3                   	ret    
80101314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
80101318:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
8010131b:	83 fb 7f             	cmp    $0x7f,%ebx
8010131e:	0f 87 90 00 00 00    	ja     801013b4 <bmap+0xc4>
    if((addr = ip->addrs[NDIRECT]) == 0)
80101324:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
8010132a:	8b 00                	mov    (%eax),%eax
8010132c:	85 d2                	test   %edx,%edx
8010132e:	74 70                	je     801013a0 <bmap+0xb0>
    bp = bread(ip->dev, addr);
80101330:	83 ec 08             	sub    $0x8,%esp
80101333:	52                   	push   %edx
80101334:	50                   	push   %eax
80101335:	e8 96 ed ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
8010133a:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010133e:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
80101341:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
80101343:	8b 1a                	mov    (%edx),%ebx
80101345:	85 db                	test   %ebx,%ebx
80101347:	75 1d                	jne    80101366 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
80101349:	8b 06                	mov    (%esi),%eax
8010134b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010134e:	e8 bd fd ff ff       	call   80101110 <balloc>
80101353:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101356:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101359:	89 c3                	mov    %eax,%ebx
8010135b:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010135d:	57                   	push   %edi
8010135e:	e8 1d 1a 00 00       	call   80102d80 <log_write>
80101363:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101366:	83 ec 0c             	sub    $0xc,%esp
80101369:	57                   	push   %edi
8010136a:	e8 71 ee ff ff       	call   801001e0 <brelse>
8010136f:	83 c4 10             	add    $0x10,%esp
}
80101372:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101375:	89 d8                	mov    %ebx,%eax
80101377:	5b                   	pop    %ebx
80101378:	5e                   	pop    %esi
80101379:	5f                   	pop    %edi
8010137a:	5d                   	pop    %ebp
8010137b:	c3                   	ret    
8010137c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
80101380:	8b 00                	mov    (%eax),%eax
80101382:	e8 89 fd ff ff       	call   80101110 <balloc>
80101387:	89 47 5c             	mov    %eax,0x5c(%edi)
}
8010138a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
8010138d:	89 c3                	mov    %eax,%ebx
}
8010138f:	89 d8                	mov    %ebx,%eax
80101391:	5b                   	pop    %ebx
80101392:	5e                   	pop    %esi
80101393:	5f                   	pop    %edi
80101394:	5d                   	pop    %ebp
80101395:	c3                   	ret    
80101396:	8d 76 00             	lea    0x0(%esi),%esi
80101399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801013a0:	e8 6b fd ff ff       	call   80101110 <balloc>
801013a5:	89 c2                	mov    %eax,%edx
801013a7:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801013ad:	8b 06                	mov    (%esi),%eax
801013af:	e9 7c ff ff ff       	jmp    80101330 <bmap+0x40>
  panic("bmap: out of range");
801013b4:	83 ec 0c             	sub    $0xc,%esp
801013b7:	68 25 72 10 80       	push   $0x80107225
801013bc:	e8 cf ef ff ff       	call   80100390 <panic>
801013c1:	eb 0d                	jmp    801013d0 <readsb>
801013c3:	90                   	nop
801013c4:	90                   	nop
801013c5:	90                   	nop
801013c6:	90                   	nop
801013c7:	90                   	nop
801013c8:	90                   	nop
801013c9:	90                   	nop
801013ca:	90                   	nop
801013cb:	90                   	nop
801013cc:	90                   	nop
801013cd:	90                   	nop
801013ce:	90                   	nop
801013cf:	90                   	nop

801013d0 <readsb>:
{
801013d0:	55                   	push   %ebp
801013d1:	89 e5                	mov    %esp,%ebp
801013d3:	56                   	push   %esi
801013d4:	53                   	push   %ebx
801013d5:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801013d8:	83 ec 08             	sub    $0x8,%esp
801013db:	6a 01                	push   $0x1
801013dd:	ff 75 08             	pushl  0x8(%ebp)
801013e0:	e8 eb ec ff ff       	call   801000d0 <bread>
801013e5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801013e7:	8d 40 5c             	lea    0x5c(%eax),%eax
801013ea:	83 c4 0c             	add    $0xc,%esp
801013ed:	6a 1c                	push   $0x1c
801013ef:	50                   	push   %eax
801013f0:	56                   	push   %esi
801013f1:	e8 ca 32 00 00       	call   801046c0 <memmove>
  brelse(bp);
801013f6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801013f9:	83 c4 10             	add    $0x10,%esp
}
801013fc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801013ff:	5b                   	pop    %ebx
80101400:	5e                   	pop    %esi
80101401:	5d                   	pop    %ebp
  brelse(bp);
80101402:	e9 d9 ed ff ff       	jmp    801001e0 <brelse>
80101407:	89 f6                	mov    %esi,%esi
80101409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101410 <bfree>:
{
80101410:	55                   	push   %ebp
80101411:	89 e5                	mov    %esp,%ebp
80101413:	56                   	push   %esi
80101414:	53                   	push   %ebx
80101415:	89 d3                	mov    %edx,%ebx
80101417:	89 c6                	mov    %eax,%esi
  readsb(dev, &sb);
80101419:	83 ec 08             	sub    $0x8,%esp
8010141c:	68 c0 09 11 80       	push   $0x801109c0
80101421:	50                   	push   %eax
80101422:	e8 a9 ff ff ff       	call   801013d0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101427:	58                   	pop    %eax
80101428:	5a                   	pop    %edx
80101429:	89 da                	mov    %ebx,%edx
8010142b:	c1 ea 0c             	shr    $0xc,%edx
8010142e:	03 15 d8 09 11 80    	add    0x801109d8,%edx
80101434:	52                   	push   %edx
80101435:	56                   	push   %esi
80101436:	e8 95 ec ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
8010143b:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010143d:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
80101440:	ba 01 00 00 00       	mov    $0x1,%edx
80101445:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101448:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010144e:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101451:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101453:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101458:	85 d1                	test   %edx,%ecx
8010145a:	74 25                	je     80101481 <bfree+0x71>
  bp->data[bi/8] &= ~m;
8010145c:	f7 d2                	not    %edx
8010145e:	89 c6                	mov    %eax,%esi
  log_write(bp);
80101460:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101463:	21 ca                	and    %ecx,%edx
80101465:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101469:	56                   	push   %esi
8010146a:	e8 11 19 00 00       	call   80102d80 <log_write>
  brelse(bp);
8010146f:	89 34 24             	mov    %esi,(%esp)
80101472:	e8 69 ed ff ff       	call   801001e0 <brelse>
}
80101477:	83 c4 10             	add    $0x10,%esp
8010147a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010147d:	5b                   	pop    %ebx
8010147e:	5e                   	pop    %esi
8010147f:	5d                   	pop    %ebp
80101480:	c3                   	ret    
    panic("freeing free block");
80101481:	83 ec 0c             	sub    $0xc,%esp
80101484:	68 38 72 10 80       	push   $0x80107238
80101489:	e8 02 ef ff ff       	call   80100390 <panic>
8010148e:	66 90                	xchg   %ax,%ax

80101490 <iinit>:
{
80101490:	55                   	push   %ebp
80101491:	89 e5                	mov    %esp,%ebp
80101493:	53                   	push   %ebx
80101494:	bb 20 0a 11 80       	mov    $0x80110a20,%ebx
80101499:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010149c:	68 4b 72 10 80       	push   $0x8010724b
801014a1:	68 e0 09 11 80       	push   $0x801109e0
801014a6:	e8 f5 2e 00 00       	call   801043a0 <initlock>
801014ab:	83 c4 10             	add    $0x10,%esp
801014ae:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801014b0:	83 ec 08             	sub    $0x8,%esp
801014b3:	68 52 72 10 80       	push   $0x80107252
801014b8:	53                   	push   %ebx
801014b9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014bf:	e8 cc 2d 00 00       	call   80104290 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801014c4:	83 c4 10             	add    $0x10,%esp
801014c7:	81 fb 40 26 11 80    	cmp    $0x80112640,%ebx
801014cd:	75 e1                	jne    801014b0 <iinit+0x20>
  readsb(dev, &sb);
801014cf:	83 ec 08             	sub    $0x8,%esp
801014d2:	68 c0 09 11 80       	push   $0x801109c0
801014d7:	ff 75 08             	pushl  0x8(%ebp)
801014da:	e8 f1 fe ff ff       	call   801013d0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014df:	ff 35 d8 09 11 80    	pushl  0x801109d8
801014e5:	ff 35 d4 09 11 80    	pushl  0x801109d4
801014eb:	ff 35 d0 09 11 80    	pushl  0x801109d0
801014f1:	ff 35 cc 09 11 80    	pushl  0x801109cc
801014f7:	ff 35 c8 09 11 80    	pushl  0x801109c8
801014fd:	ff 35 c4 09 11 80    	pushl  0x801109c4
80101503:	ff 35 c0 09 11 80    	pushl  0x801109c0
80101509:	68 b8 72 10 80       	push   $0x801072b8
8010150e:	e8 4d f1 ff ff       	call   80100660 <cprintf>
}
80101513:	83 c4 30             	add    $0x30,%esp
80101516:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101519:	c9                   	leave  
8010151a:	c3                   	ret    
8010151b:	90                   	nop
8010151c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101520 <ialloc>:
{
80101520:	55                   	push   %ebp
80101521:	89 e5                	mov    %esp,%ebp
80101523:	57                   	push   %edi
80101524:	56                   	push   %esi
80101525:	53                   	push   %ebx
80101526:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101529:	83 3d c8 09 11 80 01 	cmpl   $0x1,0x801109c8
{
80101530:	8b 45 0c             	mov    0xc(%ebp),%eax
80101533:	8b 75 08             	mov    0x8(%ebp),%esi
80101536:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101539:	0f 86 91 00 00 00    	jbe    801015d0 <ialloc+0xb0>
8010153f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101544:	eb 21                	jmp    80101567 <ialloc+0x47>
80101546:	8d 76 00             	lea    0x0(%esi),%esi
80101549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101550:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101553:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101556:	57                   	push   %edi
80101557:	e8 84 ec ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010155c:	83 c4 10             	add    $0x10,%esp
8010155f:	39 1d c8 09 11 80    	cmp    %ebx,0x801109c8
80101565:	76 69                	jbe    801015d0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101567:	89 d8                	mov    %ebx,%eax
80101569:	83 ec 08             	sub    $0x8,%esp
8010156c:	c1 e8 03             	shr    $0x3,%eax
8010156f:	03 05 d4 09 11 80    	add    0x801109d4,%eax
80101575:	50                   	push   %eax
80101576:	56                   	push   %esi
80101577:	e8 54 eb ff ff       	call   801000d0 <bread>
8010157c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010157e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101580:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
80101583:	83 e0 07             	and    $0x7,%eax
80101586:	c1 e0 06             	shl    $0x6,%eax
80101589:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010158d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101591:	75 bd                	jne    80101550 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101593:	83 ec 04             	sub    $0x4,%esp
80101596:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101599:	6a 40                	push   $0x40
8010159b:	6a 00                	push   $0x0
8010159d:	51                   	push   %ecx
8010159e:	e8 6d 30 00 00       	call   80104610 <memset>
      dip->type = type;
801015a3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801015a7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801015aa:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801015ad:	89 3c 24             	mov    %edi,(%esp)
801015b0:	e8 cb 17 00 00       	call   80102d80 <log_write>
      brelse(bp);
801015b5:	89 3c 24             	mov    %edi,(%esp)
801015b8:	e8 23 ec ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
801015bd:	83 c4 10             	add    $0x10,%esp
}
801015c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801015c3:	89 da                	mov    %ebx,%edx
801015c5:	89 f0                	mov    %esi,%eax
}
801015c7:	5b                   	pop    %ebx
801015c8:	5e                   	pop    %esi
801015c9:	5f                   	pop    %edi
801015ca:	5d                   	pop    %ebp
      return iget(dev, inum);
801015cb:	e9 50 fc ff ff       	jmp    80101220 <iget>
  panic("ialloc: no inodes");
801015d0:	83 ec 0c             	sub    $0xc,%esp
801015d3:	68 58 72 10 80       	push   $0x80107258
801015d8:	e8 b3 ed ff ff       	call   80100390 <panic>
801015dd:	8d 76 00             	lea    0x0(%esi),%esi

801015e0 <iupdate>:
{
801015e0:	55                   	push   %ebp
801015e1:	89 e5                	mov    %esp,%ebp
801015e3:	56                   	push   %esi
801015e4:	53                   	push   %ebx
801015e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015e8:	83 ec 08             	sub    $0x8,%esp
801015eb:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015ee:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015f1:	c1 e8 03             	shr    $0x3,%eax
801015f4:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801015fa:	50                   	push   %eax
801015fb:	ff 73 a4             	pushl  -0x5c(%ebx)
801015fe:	e8 cd ea ff ff       	call   801000d0 <bread>
80101603:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101605:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
80101608:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010160c:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010160f:	83 e0 07             	and    $0x7,%eax
80101612:	c1 e0 06             	shl    $0x6,%eax
80101615:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101619:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010161c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101620:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101623:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101627:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010162b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010162f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101633:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101637:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010163a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010163d:	6a 34                	push   $0x34
8010163f:	53                   	push   %ebx
80101640:	50                   	push   %eax
80101641:	e8 7a 30 00 00       	call   801046c0 <memmove>
  log_write(bp);
80101646:	89 34 24             	mov    %esi,(%esp)
80101649:	e8 32 17 00 00       	call   80102d80 <log_write>
  brelse(bp);
8010164e:	89 75 08             	mov    %esi,0x8(%ebp)
80101651:	83 c4 10             	add    $0x10,%esp
}
80101654:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101657:	5b                   	pop    %ebx
80101658:	5e                   	pop    %esi
80101659:	5d                   	pop    %ebp
  brelse(bp);
8010165a:	e9 81 eb ff ff       	jmp    801001e0 <brelse>
8010165f:	90                   	nop

80101660 <idup>:
{
80101660:	55                   	push   %ebp
80101661:	89 e5                	mov    %esp,%ebp
80101663:	53                   	push   %ebx
80101664:	83 ec 10             	sub    $0x10,%esp
80101667:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010166a:	68 e0 09 11 80       	push   $0x801109e0
8010166f:	e8 1c 2e 00 00       	call   80104490 <acquire>
  ip->ref++;
80101674:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101678:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010167f:	e8 2c 2f 00 00       	call   801045b0 <release>
}
80101684:	89 d8                	mov    %ebx,%eax
80101686:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101689:	c9                   	leave  
8010168a:	c3                   	ret    
8010168b:	90                   	nop
8010168c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101690 <ilock>:
{
80101690:	55                   	push   %ebp
80101691:	89 e5                	mov    %esp,%ebp
80101693:	56                   	push   %esi
80101694:	53                   	push   %ebx
80101695:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101698:	85 db                	test   %ebx,%ebx
8010169a:	0f 84 b7 00 00 00    	je     80101757 <ilock+0xc7>
801016a0:	8b 53 08             	mov    0x8(%ebx),%edx
801016a3:	85 d2                	test   %edx,%edx
801016a5:	0f 8e ac 00 00 00    	jle    80101757 <ilock+0xc7>
  acquiresleep(&ip->lock);
801016ab:	8d 43 0c             	lea    0xc(%ebx),%eax
801016ae:	83 ec 0c             	sub    $0xc,%esp
801016b1:	50                   	push   %eax
801016b2:	e8 19 2c 00 00       	call   801042d0 <acquiresleep>
  if(ip->valid == 0){
801016b7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801016ba:	83 c4 10             	add    $0x10,%esp
801016bd:	85 c0                	test   %eax,%eax
801016bf:	74 0f                	je     801016d0 <ilock+0x40>
}
801016c1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016c4:	5b                   	pop    %ebx
801016c5:	5e                   	pop    %esi
801016c6:	5d                   	pop    %ebp
801016c7:	c3                   	ret    
801016c8:	90                   	nop
801016c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016d0:	8b 43 04             	mov    0x4(%ebx),%eax
801016d3:	83 ec 08             	sub    $0x8,%esp
801016d6:	c1 e8 03             	shr    $0x3,%eax
801016d9:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801016df:	50                   	push   %eax
801016e0:	ff 33                	pushl  (%ebx)
801016e2:	e8 e9 e9 ff ff       	call   801000d0 <bread>
801016e7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016e9:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016ec:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016ef:	83 e0 07             	and    $0x7,%eax
801016f2:	c1 e0 06             	shl    $0x6,%eax
801016f5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801016f9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016fc:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801016ff:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101703:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101707:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010170b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010170f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101713:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101717:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010171b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010171e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101721:	6a 34                	push   $0x34
80101723:	50                   	push   %eax
80101724:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101727:	50                   	push   %eax
80101728:	e8 93 2f 00 00       	call   801046c0 <memmove>
    brelse(bp);
8010172d:	89 34 24             	mov    %esi,(%esp)
80101730:	e8 ab ea ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101735:	83 c4 10             	add    $0x10,%esp
80101738:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010173d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101744:	0f 85 77 ff ff ff    	jne    801016c1 <ilock+0x31>
      panic("ilock: no type");
8010174a:	83 ec 0c             	sub    $0xc,%esp
8010174d:	68 70 72 10 80       	push   $0x80107270
80101752:	e8 39 ec ff ff       	call   80100390 <panic>
    panic("ilock");
80101757:	83 ec 0c             	sub    $0xc,%esp
8010175a:	68 6a 72 10 80       	push   $0x8010726a
8010175f:	e8 2c ec ff ff       	call   80100390 <panic>
80101764:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010176a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101770 <iunlock>:
{
80101770:	55                   	push   %ebp
80101771:	89 e5                	mov    %esp,%ebp
80101773:	56                   	push   %esi
80101774:	53                   	push   %ebx
80101775:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101778:	85 db                	test   %ebx,%ebx
8010177a:	74 28                	je     801017a4 <iunlock+0x34>
8010177c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010177f:	83 ec 0c             	sub    $0xc,%esp
80101782:	56                   	push   %esi
80101783:	e8 e8 2b 00 00       	call   80104370 <holdingsleep>
80101788:	83 c4 10             	add    $0x10,%esp
8010178b:	85 c0                	test   %eax,%eax
8010178d:	74 15                	je     801017a4 <iunlock+0x34>
8010178f:	8b 43 08             	mov    0x8(%ebx),%eax
80101792:	85 c0                	test   %eax,%eax
80101794:	7e 0e                	jle    801017a4 <iunlock+0x34>
  releasesleep(&ip->lock);
80101796:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101799:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010179c:	5b                   	pop    %ebx
8010179d:	5e                   	pop    %esi
8010179e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010179f:	e9 8c 2b 00 00       	jmp    80104330 <releasesleep>
    panic("iunlock");
801017a4:	83 ec 0c             	sub    $0xc,%esp
801017a7:	68 7f 72 10 80       	push   $0x8010727f
801017ac:	e8 df eb ff ff       	call   80100390 <panic>
801017b1:	eb 0d                	jmp    801017c0 <iput>
801017b3:	90                   	nop
801017b4:	90                   	nop
801017b5:	90                   	nop
801017b6:	90                   	nop
801017b7:	90                   	nop
801017b8:	90                   	nop
801017b9:	90                   	nop
801017ba:	90                   	nop
801017bb:	90                   	nop
801017bc:	90                   	nop
801017bd:	90                   	nop
801017be:	90                   	nop
801017bf:	90                   	nop

801017c0 <iput>:
{
801017c0:	55                   	push   %ebp
801017c1:	89 e5                	mov    %esp,%ebp
801017c3:	57                   	push   %edi
801017c4:	56                   	push   %esi
801017c5:	53                   	push   %ebx
801017c6:	83 ec 28             	sub    $0x28,%esp
801017c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801017cc:	8d 7b 0c             	lea    0xc(%ebx),%edi
801017cf:	57                   	push   %edi
801017d0:	e8 fb 2a 00 00       	call   801042d0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801017d5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801017d8:	83 c4 10             	add    $0x10,%esp
801017db:	85 d2                	test   %edx,%edx
801017dd:	74 07                	je     801017e6 <iput+0x26>
801017df:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801017e4:	74 32                	je     80101818 <iput+0x58>
  releasesleep(&ip->lock);
801017e6:	83 ec 0c             	sub    $0xc,%esp
801017e9:	57                   	push   %edi
801017ea:	e8 41 2b 00 00       	call   80104330 <releasesleep>
  acquire(&icache.lock);
801017ef:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801017f6:	e8 95 2c 00 00       	call   80104490 <acquire>
  ip->ref--;
801017fb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801017ff:	83 c4 10             	add    $0x10,%esp
80101802:	c7 45 08 e0 09 11 80 	movl   $0x801109e0,0x8(%ebp)
}
80101809:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010180c:	5b                   	pop    %ebx
8010180d:	5e                   	pop    %esi
8010180e:	5f                   	pop    %edi
8010180f:	5d                   	pop    %ebp
  release(&icache.lock);
80101810:	e9 9b 2d 00 00       	jmp    801045b0 <release>
80101815:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101818:	83 ec 0c             	sub    $0xc,%esp
8010181b:	68 e0 09 11 80       	push   $0x801109e0
80101820:	e8 6b 2c 00 00       	call   80104490 <acquire>
    int r = ip->ref;
80101825:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101828:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010182f:	e8 7c 2d 00 00       	call   801045b0 <release>
    if(r == 1){
80101834:	83 c4 10             	add    $0x10,%esp
80101837:	83 fe 01             	cmp    $0x1,%esi
8010183a:	75 aa                	jne    801017e6 <iput+0x26>
8010183c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101842:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101845:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101848:	89 cf                	mov    %ecx,%edi
8010184a:	eb 0b                	jmp    80101857 <iput+0x97>
8010184c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101850:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101853:	39 fe                	cmp    %edi,%esi
80101855:	74 19                	je     80101870 <iput+0xb0>
    if(ip->addrs[i]){
80101857:	8b 16                	mov    (%esi),%edx
80101859:	85 d2                	test   %edx,%edx
8010185b:	74 f3                	je     80101850 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010185d:	8b 03                	mov    (%ebx),%eax
8010185f:	e8 ac fb ff ff       	call   80101410 <bfree>
      ip->addrs[i] = 0;
80101864:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010186a:	eb e4                	jmp    80101850 <iput+0x90>
8010186c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101870:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101876:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101879:	85 c0                	test   %eax,%eax
8010187b:	75 33                	jne    801018b0 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010187d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101880:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101887:	53                   	push   %ebx
80101888:	e8 53 fd ff ff       	call   801015e0 <iupdate>
      ip->type = 0;
8010188d:	31 c0                	xor    %eax,%eax
8010188f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101893:	89 1c 24             	mov    %ebx,(%esp)
80101896:	e8 45 fd ff ff       	call   801015e0 <iupdate>
      ip->valid = 0;
8010189b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801018a2:	83 c4 10             	add    $0x10,%esp
801018a5:	e9 3c ff ff ff       	jmp    801017e6 <iput+0x26>
801018aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018b0:	83 ec 08             	sub    $0x8,%esp
801018b3:	50                   	push   %eax
801018b4:	ff 33                	pushl  (%ebx)
801018b6:	e8 15 e8 ff ff       	call   801000d0 <bread>
801018bb:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801018c1:	89 7d e0             	mov    %edi,-0x20(%ebp)
801018c4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
801018c7:	8d 70 5c             	lea    0x5c(%eax),%esi
801018ca:	83 c4 10             	add    $0x10,%esp
801018cd:	89 cf                	mov    %ecx,%edi
801018cf:	eb 0e                	jmp    801018df <iput+0x11f>
801018d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018d8:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
801018db:	39 fe                	cmp    %edi,%esi
801018dd:	74 0f                	je     801018ee <iput+0x12e>
      if(a[j])
801018df:	8b 16                	mov    (%esi),%edx
801018e1:	85 d2                	test   %edx,%edx
801018e3:	74 f3                	je     801018d8 <iput+0x118>
        bfree(ip->dev, a[j]);
801018e5:	8b 03                	mov    (%ebx),%eax
801018e7:	e8 24 fb ff ff       	call   80101410 <bfree>
801018ec:	eb ea                	jmp    801018d8 <iput+0x118>
    brelse(bp);
801018ee:	83 ec 0c             	sub    $0xc,%esp
801018f1:	ff 75 e4             	pushl  -0x1c(%ebp)
801018f4:	8b 7d e0             	mov    -0x20(%ebp),%edi
801018f7:	e8 e4 e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801018fc:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101902:	8b 03                	mov    (%ebx),%eax
80101904:	e8 07 fb ff ff       	call   80101410 <bfree>
    ip->addrs[NDIRECT] = 0;
80101909:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101910:	00 00 00 
80101913:	83 c4 10             	add    $0x10,%esp
80101916:	e9 62 ff ff ff       	jmp    8010187d <iput+0xbd>
8010191b:	90                   	nop
8010191c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101920 <iunlockput>:
{
80101920:	55                   	push   %ebp
80101921:	89 e5                	mov    %esp,%ebp
80101923:	53                   	push   %ebx
80101924:	83 ec 10             	sub    $0x10,%esp
80101927:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010192a:	53                   	push   %ebx
8010192b:	e8 40 fe ff ff       	call   80101770 <iunlock>
  iput(ip);
80101930:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101933:	83 c4 10             	add    $0x10,%esp
}
80101936:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101939:	c9                   	leave  
  iput(ip);
8010193a:	e9 81 fe ff ff       	jmp    801017c0 <iput>
8010193f:	90                   	nop

80101940 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101940:	55                   	push   %ebp
80101941:	89 e5                	mov    %esp,%ebp
80101943:	8b 55 08             	mov    0x8(%ebp),%edx
80101946:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101949:	8b 0a                	mov    (%edx),%ecx
8010194b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010194e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101951:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101954:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101958:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010195b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010195f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101963:	8b 52 58             	mov    0x58(%edx),%edx
80101966:	89 50 10             	mov    %edx,0x10(%eax)
}
80101969:	5d                   	pop    %ebp
8010196a:	c3                   	ret    
8010196b:	90                   	nop
8010196c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101970 <readi>:

// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101970:	55                   	push   %ebp
80101971:	89 e5                	mov    %esp,%ebp
80101973:	57                   	push   %edi
80101974:	56                   	push   %esi
80101975:	53                   	push   %ebx
80101976:	83 ec 1c             	sub    $0x1c,%esp
80101979:	8b 45 08             	mov    0x8(%ebp),%eax
8010197c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010197f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101982:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101987:	89 75 e0             	mov    %esi,-0x20(%ebp)
8010198a:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010198d:	8b 75 10             	mov    0x10(%ebp),%esi
80101990:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101993:	0f 84 a7 00 00 00    	je     80101a40 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101999:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010199c:	8b 40 58             	mov    0x58(%eax),%eax
8010199f:	39 c6                	cmp    %eax,%esi
801019a1:	0f 87 ba 00 00 00    	ja     80101a61 <readi+0xf1>
801019a7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801019aa:	89 f9                	mov    %edi,%ecx
801019ac:	01 f1                	add    %esi,%ecx
801019ae:	0f 82 ad 00 00 00    	jb     80101a61 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801019b4:	89 c2                	mov    %eax,%edx
801019b6:	29 f2                	sub    %esi,%edx
801019b8:	39 c8                	cmp    %ecx,%eax
801019ba:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019bd:	31 ff                	xor    %edi,%edi
801019bf:	85 d2                	test   %edx,%edx
    n = ip->size - off;
801019c1:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019c4:	74 6c                	je     80101a32 <readi+0xc2>
801019c6:	8d 76 00             	lea    0x0(%esi),%esi
801019c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019d0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801019d3:	89 f2                	mov    %esi,%edx
801019d5:	c1 ea 09             	shr    $0x9,%edx
801019d8:	89 d8                	mov    %ebx,%eax
801019da:	e8 11 f9 ff ff       	call   801012f0 <bmap>
801019df:	83 ec 08             	sub    $0x8,%esp
801019e2:	50                   	push   %eax
801019e3:	ff 33                	pushl  (%ebx)
801019e5:	e8 e6 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
801019ea:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019ed:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801019ef:	89 f0                	mov    %esi,%eax
801019f1:	25 ff 01 00 00       	and    $0x1ff,%eax
801019f6:	b9 00 02 00 00       	mov    $0x200,%ecx
801019fb:	83 c4 0c             	add    $0xc,%esp
801019fe:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101a00:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101a04:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101a07:	29 fb                	sub    %edi,%ebx
80101a09:	39 d9                	cmp    %ebx,%ecx
80101a0b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a0e:	53                   	push   %ebx
80101a0f:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a10:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101a12:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a15:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101a17:	e8 a4 2c 00 00       	call   801046c0 <memmove>
    brelse(bp);
80101a1c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101a1f:	89 14 24             	mov    %edx,(%esp)
80101a22:	e8 b9 e7 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a27:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a2a:	83 c4 10             	add    $0x10,%esp
80101a2d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a30:	77 9e                	ja     801019d0 <readi+0x60>
  }
  return n;
80101a32:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a35:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a38:	5b                   	pop    %ebx
80101a39:	5e                   	pop    %esi
80101a3a:	5f                   	pop    %edi
80101a3b:	5d                   	pop    %ebp
80101a3c:	c3                   	ret    
80101a3d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a40:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101a44:	66 83 f8 09          	cmp    $0x9,%ax
80101a48:	77 17                	ja     80101a61 <readi+0xf1>
80101a4a:	8b 04 c5 60 09 11 80 	mov    -0x7feef6a0(,%eax,8),%eax
80101a51:	85 c0                	test   %eax,%eax
80101a53:	74 0c                	je     80101a61 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101a55:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101a58:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a5b:	5b                   	pop    %ebx
80101a5c:	5e                   	pop    %esi
80101a5d:	5f                   	pop    %edi
80101a5e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101a5f:	ff e0                	jmp    *%eax
      return -1;
80101a61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a66:	eb cd                	jmp    80101a35 <readi+0xc5>
80101a68:	90                   	nop
80101a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101a70 <writei>:

// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a70:	55                   	push   %ebp
80101a71:	89 e5                	mov    %esp,%ebp
80101a73:	57                   	push   %edi
80101a74:	56                   	push   %esi
80101a75:	53                   	push   %ebx
80101a76:	83 ec 1c             	sub    $0x1c,%esp
80101a79:	8b 45 08             	mov    0x8(%ebp),%eax
80101a7c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a7f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a82:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101a87:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101a8a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a8d:	8b 75 10             	mov    0x10(%ebp),%esi
80101a90:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101a93:	0f 84 b7 00 00 00    	je     80101b50 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101a99:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a9c:	39 70 58             	cmp    %esi,0x58(%eax)
80101a9f:	0f 82 eb 00 00 00    	jb     80101b90 <writei+0x120>
80101aa5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101aa8:	31 d2                	xor    %edx,%edx
80101aaa:	89 f8                	mov    %edi,%eax
80101aac:	01 f0                	add    %esi,%eax
80101aae:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101ab1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101ab6:	0f 87 d4 00 00 00    	ja     80101b90 <writei+0x120>
80101abc:	85 d2                	test   %edx,%edx
80101abe:	0f 85 cc 00 00 00    	jne    80101b90 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ac4:	85 ff                	test   %edi,%edi
80101ac6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101acd:	74 72                	je     80101b41 <writei+0xd1>
80101acf:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ad0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101ad3:	89 f2                	mov    %esi,%edx
80101ad5:	c1 ea 09             	shr    $0x9,%edx
80101ad8:	89 f8                	mov    %edi,%eax
80101ada:	e8 11 f8 ff ff       	call   801012f0 <bmap>
80101adf:	83 ec 08             	sub    $0x8,%esp
80101ae2:	50                   	push   %eax
80101ae3:	ff 37                	pushl  (%edi)
80101ae5:	e8 e6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101aea:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101aed:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101af0:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101af2:	89 f0                	mov    %esi,%eax
80101af4:	b9 00 02 00 00       	mov    $0x200,%ecx
80101af9:	83 c4 0c             	add    $0xc,%esp
80101afc:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b01:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101b03:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b07:	39 d9                	cmp    %ebx,%ecx
80101b09:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101b0c:	53                   	push   %ebx
80101b0d:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b10:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101b12:	50                   	push   %eax
80101b13:	e8 a8 2b 00 00       	call   801046c0 <memmove>
    log_write(bp);
80101b18:	89 3c 24             	mov    %edi,(%esp)
80101b1b:	e8 60 12 00 00       	call   80102d80 <log_write>
    brelse(bp);
80101b20:	89 3c 24             	mov    %edi,(%esp)
80101b23:	e8 b8 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b28:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b2b:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b2e:	83 c4 10             	add    $0x10,%esp
80101b31:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b34:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101b37:	77 97                	ja     80101ad0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101b39:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b3c:	3b 70 58             	cmp    0x58(%eax),%esi
80101b3f:	77 37                	ja     80101b78 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b41:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b44:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b47:	5b                   	pop    %ebx
80101b48:	5e                   	pop    %esi
80101b49:	5f                   	pop    %edi
80101b4a:	5d                   	pop    %ebp
80101b4b:	c3                   	ret    
80101b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b50:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b54:	66 83 f8 09          	cmp    $0x9,%ax
80101b58:	77 36                	ja     80101b90 <writei+0x120>
80101b5a:	8b 04 c5 64 09 11 80 	mov    -0x7feef69c(,%eax,8),%eax
80101b61:	85 c0                	test   %eax,%eax
80101b63:	74 2b                	je     80101b90 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101b65:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b68:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b6b:	5b                   	pop    %ebx
80101b6c:	5e                   	pop    %esi
80101b6d:	5f                   	pop    %edi
80101b6e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101b6f:	ff e0                	jmp    *%eax
80101b71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101b78:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101b7b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101b7e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101b81:	50                   	push   %eax
80101b82:	e8 59 fa ff ff       	call   801015e0 <iupdate>
80101b87:	83 c4 10             	add    $0x10,%esp
80101b8a:	eb b5                	jmp    80101b41 <writei+0xd1>
80101b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101b90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b95:	eb ad                	jmp    80101b44 <writei+0xd4>
80101b97:	89 f6                	mov    %esi,%esi
80101b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ba0 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
80101ba0:	55                   	push   %ebp
80101ba1:	89 e5                	mov    %esp,%ebp
80101ba3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101ba6:	6a 0e                	push   $0xe
80101ba8:	ff 75 0c             	pushl  0xc(%ebp)
80101bab:	ff 75 08             	pushl  0x8(%ebp)
80101bae:	e8 8d 2b 00 00       	call   80104740 <strncmp>
}
80101bb3:	c9                   	leave  
80101bb4:	c3                   	ret    
80101bb5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bc0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101bc0:	55                   	push   %ebp
80101bc1:	89 e5                	mov    %esp,%ebp
80101bc3:	57                   	push   %edi
80101bc4:	56                   	push   %esi
80101bc5:	53                   	push   %ebx
80101bc6:	83 ec 1c             	sub    $0x1c,%esp
80101bc9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101bcc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101bd1:	0f 85 85 00 00 00    	jne    80101c5c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101bd7:	8b 53 58             	mov    0x58(%ebx),%edx
80101bda:	31 ff                	xor    %edi,%edi
80101bdc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101bdf:	85 d2                	test   %edx,%edx
80101be1:	74 3e                	je     80101c21 <dirlookup+0x61>
80101be3:	90                   	nop
80101be4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101be8:	6a 10                	push   $0x10
80101bea:	57                   	push   %edi
80101beb:	56                   	push   %esi
80101bec:	53                   	push   %ebx
80101bed:	e8 7e fd ff ff       	call   80101970 <readi>
80101bf2:	83 c4 10             	add    $0x10,%esp
80101bf5:	83 f8 10             	cmp    $0x10,%eax
80101bf8:	75 55                	jne    80101c4f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101bfa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101bff:	74 18                	je     80101c19 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101c01:	8d 45 da             	lea    -0x26(%ebp),%eax
80101c04:	83 ec 04             	sub    $0x4,%esp
80101c07:	6a 0e                	push   $0xe
80101c09:	50                   	push   %eax
80101c0a:	ff 75 0c             	pushl  0xc(%ebp)
80101c0d:	e8 2e 2b 00 00       	call   80104740 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101c12:	83 c4 10             	add    $0x10,%esp
80101c15:	85 c0                	test   %eax,%eax
80101c17:	74 17                	je     80101c30 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101c19:	83 c7 10             	add    $0x10,%edi
80101c1c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101c1f:	72 c7                	jb     80101be8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101c21:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101c24:	31 c0                	xor    %eax,%eax
}
80101c26:	5b                   	pop    %ebx
80101c27:	5e                   	pop    %esi
80101c28:	5f                   	pop    %edi
80101c29:	5d                   	pop    %ebp
80101c2a:	c3                   	ret    
80101c2b:	90                   	nop
80101c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101c30:	8b 45 10             	mov    0x10(%ebp),%eax
80101c33:	85 c0                	test   %eax,%eax
80101c35:	74 05                	je     80101c3c <dirlookup+0x7c>
        *poff = off;
80101c37:	8b 45 10             	mov    0x10(%ebp),%eax
80101c3a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101c3c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101c40:	8b 03                	mov    (%ebx),%eax
80101c42:	e8 d9 f5 ff ff       	call   80101220 <iget>
}
80101c47:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c4a:	5b                   	pop    %ebx
80101c4b:	5e                   	pop    %esi
80101c4c:	5f                   	pop    %edi
80101c4d:	5d                   	pop    %ebp
80101c4e:	c3                   	ret    
      panic("dirlookup read");
80101c4f:	83 ec 0c             	sub    $0xc,%esp
80101c52:	68 99 72 10 80       	push   $0x80107299
80101c57:	e8 34 e7 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101c5c:	83 ec 0c             	sub    $0xc,%esp
80101c5f:	68 87 72 10 80       	push   $0x80107287
80101c64:	e8 27 e7 ff ff       	call   80100390 <panic>
80101c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101c70 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c70:	55                   	push   %ebp
80101c71:	89 e5                	mov    %esp,%ebp
80101c73:	57                   	push   %edi
80101c74:	56                   	push   %esi
80101c75:	53                   	push   %ebx
80101c76:	89 cf                	mov    %ecx,%edi
80101c78:	89 c3                	mov    %eax,%ebx
80101c7a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101c7d:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101c80:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101c83:	0f 84 67 01 00 00    	je     80101df0 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101c89:	e8 72 1b 00 00       	call   80103800 <myproc>
  acquire(&icache.lock);
80101c8e:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101c91:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101c94:	68 e0 09 11 80       	push   $0x801109e0
80101c99:	e8 f2 27 00 00       	call   80104490 <acquire>
  ip->ref++;
80101c9e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101ca2:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101ca9:	e8 02 29 00 00       	call   801045b0 <release>
80101cae:	83 c4 10             	add    $0x10,%esp
80101cb1:	eb 08                	jmp    80101cbb <namex+0x4b>
80101cb3:	90                   	nop
80101cb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101cb8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101cbb:	0f b6 03             	movzbl (%ebx),%eax
80101cbe:	3c 2f                	cmp    $0x2f,%al
80101cc0:	74 f6                	je     80101cb8 <namex+0x48>
  if(*path == 0)
80101cc2:	84 c0                	test   %al,%al
80101cc4:	0f 84 ee 00 00 00    	je     80101db8 <namex+0x148>
  while(*path != '/' && *path != 0)
80101cca:	0f b6 03             	movzbl (%ebx),%eax
80101ccd:	3c 2f                	cmp    $0x2f,%al
80101ccf:	0f 84 b3 00 00 00    	je     80101d88 <namex+0x118>
80101cd5:	84 c0                	test   %al,%al
80101cd7:	89 da                	mov    %ebx,%edx
80101cd9:	75 09                	jne    80101ce4 <namex+0x74>
80101cdb:	e9 a8 00 00 00       	jmp    80101d88 <namex+0x118>
80101ce0:	84 c0                	test   %al,%al
80101ce2:	74 0a                	je     80101cee <namex+0x7e>
    path++;
80101ce4:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101ce7:	0f b6 02             	movzbl (%edx),%eax
80101cea:	3c 2f                	cmp    $0x2f,%al
80101cec:	75 f2                	jne    80101ce0 <namex+0x70>
80101cee:	89 d1                	mov    %edx,%ecx
80101cf0:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101cf2:	83 f9 0d             	cmp    $0xd,%ecx
80101cf5:	0f 8e 91 00 00 00    	jle    80101d8c <namex+0x11c>
    memmove(name, s, DIRSIZ);
80101cfb:	83 ec 04             	sub    $0x4,%esp
80101cfe:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101d01:	6a 0e                	push   $0xe
80101d03:	53                   	push   %ebx
80101d04:	57                   	push   %edi
80101d05:	e8 b6 29 00 00       	call   801046c0 <memmove>
    path++;
80101d0a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101d0d:	83 c4 10             	add    $0x10,%esp
    path++;
80101d10:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101d12:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101d15:	75 11                	jne    80101d28 <namex+0xb8>
80101d17:	89 f6                	mov    %esi,%esi
80101d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101d20:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101d23:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d26:	74 f8                	je     80101d20 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101d28:	83 ec 0c             	sub    $0xc,%esp
80101d2b:	56                   	push   %esi
80101d2c:	e8 5f f9 ff ff       	call   80101690 <ilock>
    if(ip->type != T_DIR){
80101d31:	83 c4 10             	add    $0x10,%esp
80101d34:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d39:	0f 85 91 00 00 00    	jne    80101dd0 <namex+0x160>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d3f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d42:	85 d2                	test   %edx,%edx
80101d44:	74 09                	je     80101d4f <namex+0xdf>
80101d46:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d49:	0f 84 b7 00 00 00    	je     80101e06 <namex+0x196>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d4f:	83 ec 04             	sub    $0x4,%esp
80101d52:	6a 00                	push   $0x0
80101d54:	57                   	push   %edi
80101d55:	56                   	push   %esi
80101d56:	e8 65 fe ff ff       	call   80101bc0 <dirlookup>
80101d5b:	83 c4 10             	add    $0x10,%esp
80101d5e:	85 c0                	test   %eax,%eax
80101d60:	74 6e                	je     80101dd0 <namex+0x160>
  iunlock(ip);
80101d62:	83 ec 0c             	sub    $0xc,%esp
80101d65:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d68:	56                   	push   %esi
80101d69:	e8 02 fa ff ff       	call   80101770 <iunlock>
  iput(ip);
80101d6e:	89 34 24             	mov    %esi,(%esp)
80101d71:	e8 4a fa ff ff       	call   801017c0 <iput>
80101d76:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d79:	83 c4 10             	add    $0x10,%esp
80101d7c:	89 c6                	mov    %eax,%esi
80101d7e:	e9 38 ff ff ff       	jmp    80101cbb <namex+0x4b>
80101d83:	90                   	nop
80101d84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101d88:	89 da                	mov    %ebx,%edx
80101d8a:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101d8c:	83 ec 04             	sub    $0x4,%esp
80101d8f:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101d92:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101d95:	51                   	push   %ecx
80101d96:	53                   	push   %ebx
80101d97:	57                   	push   %edi
80101d98:	e8 23 29 00 00       	call   801046c0 <memmove>
    name[len] = 0;
80101d9d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101da0:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101da3:	83 c4 10             	add    $0x10,%esp
80101da6:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101daa:	89 d3                	mov    %edx,%ebx
80101dac:	e9 61 ff ff ff       	jmp    80101d12 <namex+0xa2>
80101db1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101db8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101dbb:	85 c0                	test   %eax,%eax
80101dbd:	75 5d                	jne    80101e1c <namex+0x1ac>
    iput(ip);
    return 0;
  }
  return ip;
}
80101dbf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dc2:	89 f0                	mov    %esi,%eax
80101dc4:	5b                   	pop    %ebx
80101dc5:	5e                   	pop    %esi
80101dc6:	5f                   	pop    %edi
80101dc7:	5d                   	pop    %ebp
80101dc8:	c3                   	ret    
80101dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101dd0:	83 ec 0c             	sub    $0xc,%esp
80101dd3:	56                   	push   %esi
80101dd4:	e8 97 f9 ff ff       	call   80101770 <iunlock>
  iput(ip);
80101dd9:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101ddc:	31 f6                	xor    %esi,%esi
  iput(ip);
80101dde:	e8 dd f9 ff ff       	call   801017c0 <iput>
      return 0;
80101de3:	83 c4 10             	add    $0x10,%esp
}
80101de6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101de9:	89 f0                	mov    %esi,%eax
80101deb:	5b                   	pop    %ebx
80101dec:	5e                   	pop    %esi
80101ded:	5f                   	pop    %edi
80101dee:	5d                   	pop    %ebp
80101def:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101df0:	ba 01 00 00 00       	mov    $0x1,%edx
80101df5:	b8 01 00 00 00       	mov    $0x1,%eax
80101dfa:	e8 21 f4 ff ff       	call   80101220 <iget>
80101dff:	89 c6                	mov    %eax,%esi
80101e01:	e9 b5 fe ff ff       	jmp    80101cbb <namex+0x4b>
      iunlock(ip);
80101e06:	83 ec 0c             	sub    $0xc,%esp
80101e09:	56                   	push   %esi
80101e0a:	e8 61 f9 ff ff       	call   80101770 <iunlock>
      return ip;
80101e0f:	83 c4 10             	add    $0x10,%esp
}
80101e12:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e15:	89 f0                	mov    %esi,%eax
80101e17:	5b                   	pop    %ebx
80101e18:	5e                   	pop    %esi
80101e19:	5f                   	pop    %edi
80101e1a:	5d                   	pop    %ebp
80101e1b:	c3                   	ret    
    iput(ip);
80101e1c:	83 ec 0c             	sub    $0xc,%esp
80101e1f:	56                   	push   %esi
    return 0;
80101e20:	31 f6                	xor    %esi,%esi
    iput(ip);
80101e22:	e8 99 f9 ff ff       	call   801017c0 <iput>
    return 0;
80101e27:	83 c4 10             	add    $0x10,%esp
80101e2a:	eb 93                	jmp    80101dbf <namex+0x14f>
80101e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101e30 <dirlink>:
{
80101e30:	55                   	push   %ebp
80101e31:	89 e5                	mov    %esp,%ebp
80101e33:	57                   	push   %edi
80101e34:	56                   	push   %esi
80101e35:	53                   	push   %ebx
80101e36:	83 ec 20             	sub    $0x20,%esp
80101e39:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101e3c:	6a 00                	push   $0x0
80101e3e:	ff 75 0c             	pushl  0xc(%ebp)
80101e41:	53                   	push   %ebx
80101e42:	e8 79 fd ff ff       	call   80101bc0 <dirlookup>
80101e47:	83 c4 10             	add    $0x10,%esp
80101e4a:	85 c0                	test   %eax,%eax
80101e4c:	75 67                	jne    80101eb5 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e4e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101e51:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e54:	85 ff                	test   %edi,%edi
80101e56:	74 29                	je     80101e81 <dirlink+0x51>
80101e58:	31 ff                	xor    %edi,%edi
80101e5a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e5d:	eb 09                	jmp    80101e68 <dirlink+0x38>
80101e5f:	90                   	nop
80101e60:	83 c7 10             	add    $0x10,%edi
80101e63:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101e66:	73 19                	jae    80101e81 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e68:	6a 10                	push   $0x10
80101e6a:	57                   	push   %edi
80101e6b:	56                   	push   %esi
80101e6c:	53                   	push   %ebx
80101e6d:	e8 fe fa ff ff       	call   80101970 <readi>
80101e72:	83 c4 10             	add    $0x10,%esp
80101e75:	83 f8 10             	cmp    $0x10,%eax
80101e78:	75 4e                	jne    80101ec8 <dirlink+0x98>
    if(de.inum == 0)
80101e7a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e7f:	75 df                	jne    80101e60 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101e81:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e84:	83 ec 04             	sub    $0x4,%esp
80101e87:	6a 0e                	push   $0xe
80101e89:	ff 75 0c             	pushl  0xc(%ebp)
80101e8c:	50                   	push   %eax
80101e8d:	e8 1e 29 00 00       	call   801047b0 <strncpy>
  de.inum = inum;
80101e92:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e95:	6a 10                	push   $0x10
80101e97:	57                   	push   %edi
80101e98:	56                   	push   %esi
80101e99:	53                   	push   %ebx
  de.inum = inum;
80101e9a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e9e:	e8 cd fb ff ff       	call   80101a70 <writei>
80101ea3:	83 c4 20             	add    $0x20,%esp
80101ea6:	83 f8 10             	cmp    $0x10,%eax
80101ea9:	75 2a                	jne    80101ed5 <dirlink+0xa5>
  return 0;
80101eab:	31 c0                	xor    %eax,%eax
}
80101ead:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101eb0:	5b                   	pop    %ebx
80101eb1:	5e                   	pop    %esi
80101eb2:	5f                   	pop    %edi
80101eb3:	5d                   	pop    %ebp
80101eb4:	c3                   	ret    
    iput(ip);
80101eb5:	83 ec 0c             	sub    $0xc,%esp
80101eb8:	50                   	push   %eax
80101eb9:	e8 02 f9 ff ff       	call   801017c0 <iput>
    return -1;
80101ebe:	83 c4 10             	add    $0x10,%esp
80101ec1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ec6:	eb e5                	jmp    80101ead <dirlink+0x7d>
      panic("dirlink read");
80101ec8:	83 ec 0c             	sub    $0xc,%esp
80101ecb:	68 a8 72 10 80       	push   $0x801072a8
80101ed0:	e8 bb e4 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101ed5:	83 ec 0c             	sub    $0xc,%esp
80101ed8:	68 2a 79 10 80       	push   $0x8010792a
80101edd:	e8 ae e4 ff ff       	call   80100390 <panic>
80101ee2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ef0 <namei>:

struct inode*
namei(char *path)
{
80101ef0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101ef1:	31 d2                	xor    %edx,%edx
{
80101ef3:	89 e5                	mov    %esp,%ebp
80101ef5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101ef8:	8b 45 08             	mov    0x8(%ebp),%eax
80101efb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101efe:	e8 6d fd ff ff       	call   80101c70 <namex>
}
80101f03:	c9                   	leave  
80101f04:	c3                   	ret    
80101f05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f10 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101f10:	55                   	push   %ebp
  return namex(path, 1, name);
80101f11:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101f16:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101f18:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101f1b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101f1e:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101f1f:	e9 4c fd ff ff       	jmp    80101c70 <namex>
80101f24:	66 90                	xchg   %ax,%ax
80101f26:	66 90                	xchg   %ax,%ax
80101f28:	66 90                	xchg   %ax,%ax
80101f2a:	66 90                	xchg   %ax,%ax
80101f2c:	66 90                	xchg   %ax,%ax
80101f2e:	66 90                	xchg   %ax,%ax

80101f30 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f30:	55                   	push   %ebp
80101f31:	89 e5                	mov    %esp,%ebp
80101f33:	57                   	push   %edi
80101f34:	56                   	push   %esi
80101f35:	53                   	push   %ebx
80101f36:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80101f39:	85 c0                	test   %eax,%eax
80101f3b:	0f 84 b4 00 00 00    	je     80101ff5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101f41:	8b 58 08             	mov    0x8(%eax),%ebx
80101f44:	89 c6                	mov    %eax,%esi
80101f46:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101f4c:	0f 87 96 00 00 00    	ja     80101fe8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f52:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80101f57:	89 f6                	mov    %esi,%esi
80101f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101f60:	89 ca                	mov    %ecx,%edx
80101f62:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f63:	83 e0 c0             	and    $0xffffffc0,%eax
80101f66:	3c 40                	cmp    $0x40,%al
80101f68:	75 f6                	jne    80101f60 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f6a:	31 ff                	xor    %edi,%edi
80101f6c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f71:	89 f8                	mov    %edi,%eax
80101f73:	ee                   	out    %al,(%dx)
80101f74:	b8 01 00 00 00       	mov    $0x1,%eax
80101f79:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f7e:	ee                   	out    %al,(%dx)
80101f7f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101f84:	89 d8                	mov    %ebx,%eax
80101f86:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101f87:	89 d8                	mov    %ebx,%eax
80101f89:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101f8e:	c1 f8 08             	sar    $0x8,%eax
80101f91:	ee                   	out    %al,(%dx)
80101f92:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101f97:	89 f8                	mov    %edi,%eax
80101f99:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101f9a:	0f b6 46 04          	movzbl 0x4(%esi),%eax
80101f9e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101fa3:	c1 e0 04             	shl    $0x4,%eax
80101fa6:	83 e0 10             	and    $0x10,%eax
80101fa9:	83 c8 e0             	or     $0xffffffe0,%eax
80101fac:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101fad:	f6 06 04             	testb  $0x4,(%esi)
80101fb0:	75 16                	jne    80101fc8 <idestart+0x98>
80101fb2:	b8 20 00 00 00       	mov    $0x20,%eax
80101fb7:	89 ca                	mov    %ecx,%edx
80101fb9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101fba:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fbd:	5b                   	pop    %ebx
80101fbe:	5e                   	pop    %esi
80101fbf:	5f                   	pop    %edi
80101fc0:	5d                   	pop    %ebp
80101fc1:	c3                   	ret    
80101fc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101fc8:	b8 30 00 00 00       	mov    $0x30,%eax
80101fcd:	89 ca                	mov    %ecx,%edx
80101fcf:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80101fd0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80101fd5:	83 c6 5c             	add    $0x5c,%esi
80101fd8:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101fdd:	fc                   	cld    
80101fde:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80101fe0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fe3:	5b                   	pop    %ebx
80101fe4:	5e                   	pop    %esi
80101fe5:	5f                   	pop    %edi
80101fe6:	5d                   	pop    %ebp
80101fe7:	c3                   	ret    
    panic("incorrect blockno");
80101fe8:	83 ec 0c             	sub    $0xc,%esp
80101feb:	68 14 73 10 80       	push   $0x80107314
80101ff0:	e8 9b e3 ff ff       	call   80100390 <panic>
    panic("idestart");
80101ff5:	83 ec 0c             	sub    $0xc,%esp
80101ff8:	68 0b 73 10 80       	push   $0x8010730b
80101ffd:	e8 8e e3 ff ff       	call   80100390 <panic>
80102002:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102010 <ideinit>:
{
80102010:	55                   	push   %ebp
80102011:	89 e5                	mov    %esp,%ebp
80102013:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102016:	68 26 73 10 80       	push   $0x80107326
8010201b:	68 80 a5 10 80       	push   $0x8010a580
80102020:	e8 7b 23 00 00       	call   801043a0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102025:	58                   	pop    %eax
80102026:	a1 00 2d 11 80       	mov    0x80112d00,%eax
8010202b:	5a                   	pop    %edx
8010202c:	83 e8 01             	sub    $0x1,%eax
8010202f:	50                   	push   %eax
80102030:	6a 0e                	push   $0xe
80102032:	e8 a9 02 00 00       	call   801022e0 <ioapicenable>
80102037:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010203a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010203f:	90                   	nop
80102040:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102041:	83 e0 c0             	and    $0xffffffc0,%eax
80102044:	3c 40                	cmp    $0x40,%al
80102046:	75 f8                	jne    80102040 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102048:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010204d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102052:	ee                   	out    %al,(%dx)
80102053:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102058:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010205d:	eb 06                	jmp    80102065 <ideinit+0x55>
8010205f:	90                   	nop
  for(i=0; i<1000; i++){
80102060:	83 e9 01             	sub    $0x1,%ecx
80102063:	74 0f                	je     80102074 <ideinit+0x64>
80102065:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102066:	84 c0                	test   %al,%al
80102068:	74 f6                	je     80102060 <ideinit+0x50>
      havedisk1 = 1;
8010206a:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102071:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102074:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102079:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010207e:	ee                   	out    %al,(%dx)
}
8010207f:	c9                   	leave  
80102080:	c3                   	ret    
80102081:	eb 0d                	jmp    80102090 <ideintr>
80102083:	90                   	nop
80102084:	90                   	nop
80102085:	90                   	nop
80102086:	90                   	nop
80102087:	90                   	nop
80102088:	90                   	nop
80102089:	90                   	nop
8010208a:	90                   	nop
8010208b:	90                   	nop
8010208c:	90                   	nop
8010208d:	90                   	nop
8010208e:	90                   	nop
8010208f:	90                   	nop

80102090 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102090:	55                   	push   %ebp
80102091:	89 e5                	mov    %esp,%ebp
80102093:	57                   	push   %edi
80102094:	56                   	push   %esi
80102095:	53                   	push   %ebx
80102096:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102099:	68 80 a5 10 80       	push   $0x8010a580
8010209e:	e8 ed 23 00 00       	call   80104490 <acquire>

  if((b = idequeue) == 0){
801020a3:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
801020a9:	83 c4 10             	add    $0x10,%esp
801020ac:	85 db                	test   %ebx,%ebx
801020ae:	74 67                	je     80102117 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801020b0:	8b 43 58             	mov    0x58(%ebx),%eax
801020b3:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801020b8:	8b 3b                	mov    (%ebx),%edi
801020ba:	f7 c7 04 00 00 00    	test   $0x4,%edi
801020c0:	75 31                	jne    801020f3 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020c2:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020c7:	89 f6                	mov    %esi,%esi
801020c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801020d0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020d1:	89 c6                	mov    %eax,%esi
801020d3:	83 e6 c0             	and    $0xffffffc0,%esi
801020d6:	89 f1                	mov    %esi,%ecx
801020d8:	80 f9 40             	cmp    $0x40,%cl
801020db:	75 f3                	jne    801020d0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801020dd:	a8 21                	test   $0x21,%al
801020df:	75 12                	jne    801020f3 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
801020e1:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801020e4:	b9 80 00 00 00       	mov    $0x80,%ecx
801020e9:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020ee:	fc                   	cld    
801020ef:	f3 6d                	rep insl (%dx),%es:(%edi)
801020f1:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801020f3:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
801020f6:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801020f9:	89 f9                	mov    %edi,%ecx
801020fb:	83 c9 02             	or     $0x2,%ecx
801020fe:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
80102100:	53                   	push   %ebx
80102101:	e8 6a 1e 00 00       	call   80103f70 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102106:	a1 64 a5 10 80       	mov    0x8010a564,%eax
8010210b:	83 c4 10             	add    $0x10,%esp
8010210e:	85 c0                	test   %eax,%eax
80102110:	74 05                	je     80102117 <ideintr+0x87>
    idestart(idequeue);
80102112:	e8 19 fe ff ff       	call   80101f30 <idestart>
    release(&idelock);
80102117:	83 ec 0c             	sub    $0xc,%esp
8010211a:	68 80 a5 10 80       	push   $0x8010a580
8010211f:	e8 8c 24 00 00       	call   801045b0 <release>

  release(&idelock);
}
80102124:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102127:	5b                   	pop    %ebx
80102128:	5e                   	pop    %esi
80102129:	5f                   	pop    %edi
8010212a:	5d                   	pop    %ebp
8010212b:	c3                   	ret    
8010212c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102130 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102130:	55                   	push   %ebp
80102131:	89 e5                	mov    %esp,%ebp
80102133:	53                   	push   %ebx
80102134:	83 ec 10             	sub    $0x10,%esp
80102137:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010213a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010213d:	50                   	push   %eax
8010213e:	e8 2d 22 00 00       	call   80104370 <holdingsleep>
80102143:	83 c4 10             	add    $0x10,%esp
80102146:	85 c0                	test   %eax,%eax
80102148:	0f 84 c6 00 00 00    	je     80102214 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010214e:	8b 03                	mov    (%ebx),%eax
80102150:	83 e0 06             	and    $0x6,%eax
80102153:	83 f8 02             	cmp    $0x2,%eax
80102156:	0f 84 ab 00 00 00    	je     80102207 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010215c:	8b 53 04             	mov    0x4(%ebx),%edx
8010215f:	85 d2                	test   %edx,%edx
80102161:	74 0d                	je     80102170 <iderw+0x40>
80102163:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102168:	85 c0                	test   %eax,%eax
8010216a:	0f 84 b1 00 00 00    	je     80102221 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102170:	83 ec 0c             	sub    $0xc,%esp
80102173:	68 80 a5 10 80       	push   $0x8010a580
80102178:	e8 13 23 00 00       	call   80104490 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010217d:	8b 15 64 a5 10 80    	mov    0x8010a564,%edx
80102183:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
80102186:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010218d:	85 d2                	test   %edx,%edx
8010218f:	75 09                	jne    8010219a <iderw+0x6a>
80102191:	eb 6d                	jmp    80102200 <iderw+0xd0>
80102193:	90                   	nop
80102194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102198:	89 c2                	mov    %eax,%edx
8010219a:	8b 42 58             	mov    0x58(%edx),%eax
8010219d:	85 c0                	test   %eax,%eax
8010219f:	75 f7                	jne    80102198 <iderw+0x68>
801021a1:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801021a4:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801021a6:	39 1d 64 a5 10 80    	cmp    %ebx,0x8010a564
801021ac:	74 42                	je     801021f0 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021ae:	8b 03                	mov    (%ebx),%eax
801021b0:	83 e0 06             	and    $0x6,%eax
801021b3:	83 f8 02             	cmp    $0x2,%eax
801021b6:	74 23                	je     801021db <iderw+0xab>
801021b8:	90                   	nop
801021b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
801021c0:	83 ec 08             	sub    $0x8,%esp
801021c3:	68 80 a5 10 80       	push   $0x8010a580
801021c8:	53                   	push   %ebx
801021c9:	e8 f2 1b 00 00       	call   80103dc0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021ce:	8b 03                	mov    (%ebx),%eax
801021d0:	83 c4 10             	add    $0x10,%esp
801021d3:	83 e0 06             	and    $0x6,%eax
801021d6:	83 f8 02             	cmp    $0x2,%eax
801021d9:	75 e5                	jne    801021c0 <iderw+0x90>
  }


  release(&idelock);
801021db:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
801021e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801021e5:	c9                   	leave  
  release(&idelock);
801021e6:	e9 c5 23 00 00       	jmp    801045b0 <release>
801021eb:	90                   	nop
801021ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
801021f0:	89 d8                	mov    %ebx,%eax
801021f2:	e8 39 fd ff ff       	call   80101f30 <idestart>
801021f7:	eb b5                	jmp    801021ae <iderw+0x7e>
801021f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102200:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
80102205:	eb 9d                	jmp    801021a4 <iderw+0x74>
    panic("iderw: nothing to do");
80102207:	83 ec 0c             	sub    $0xc,%esp
8010220a:	68 40 73 10 80       	push   $0x80107340
8010220f:	e8 7c e1 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102214:	83 ec 0c             	sub    $0xc,%esp
80102217:	68 2a 73 10 80       	push   $0x8010732a
8010221c:	e8 6f e1 ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102221:	83 ec 0c             	sub    $0xc,%esp
80102224:	68 55 73 10 80       	push   $0x80107355
80102229:	e8 62 e1 ff ff       	call   80100390 <panic>
8010222e:	66 90                	xchg   %ax,%ax

80102230 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102230:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102231:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
80102238:	00 c0 fe 
{
8010223b:	89 e5                	mov    %esp,%ebp
8010223d:	56                   	push   %esi
8010223e:	53                   	push   %ebx
  ioapic->reg = reg;
8010223f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102246:	00 00 00 
  return ioapic->data;
80102249:	a1 34 26 11 80       	mov    0x80112634,%eax
8010224e:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102251:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
80102257:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010225d:	0f b6 15 60 27 11 80 	movzbl 0x80112760,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102264:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
80102267:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
8010226a:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
8010226d:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102270:	39 c2                	cmp    %eax,%edx
80102272:	74 16                	je     8010228a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102274:	83 ec 0c             	sub    $0xc,%esp
80102277:	68 74 73 10 80       	push   $0x80107374
8010227c:	e8 df e3 ff ff       	call   80100660 <cprintf>
80102281:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
80102287:	83 c4 10             	add    $0x10,%esp
8010228a:	83 c3 21             	add    $0x21,%ebx
{
8010228d:	ba 10 00 00 00       	mov    $0x10,%edx
80102292:	b8 20 00 00 00       	mov    $0x20,%eax
80102297:	89 f6                	mov    %esi,%esi
80102299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
801022a0:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
801022a2:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801022a8:	89 c6                	mov    %eax,%esi
801022aa:	81 ce 00 00 01 00    	or     $0x10000,%esi
801022b0:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022b3:	89 71 10             	mov    %esi,0x10(%ecx)
801022b6:	8d 72 01             	lea    0x1(%edx),%esi
801022b9:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
801022bc:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
801022be:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
801022c0:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
801022c6:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
801022cd:	75 d1                	jne    801022a0 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801022cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022d2:	5b                   	pop    %ebx
801022d3:	5e                   	pop    %esi
801022d4:	5d                   	pop    %ebp
801022d5:	c3                   	ret    
801022d6:	8d 76 00             	lea    0x0(%esi),%esi
801022d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801022e0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801022e0:	55                   	push   %ebp
  ioapic->reg = reg;
801022e1:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
{
801022e7:	89 e5                	mov    %esp,%ebp
801022e9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801022ec:	8d 50 20             	lea    0x20(%eax),%edx
801022ef:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801022f3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801022f5:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022fb:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022fe:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102301:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102304:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102306:	a1 34 26 11 80       	mov    0x80112634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010230b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010230e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102311:	5d                   	pop    %ebp
80102312:	c3                   	ret    
80102313:	66 90                	xchg   %ax,%ax
80102315:	66 90                	xchg   %ax,%ax
80102317:	66 90                	xchg   %ax,%ax
80102319:	66 90                	xchg   %ax,%ax
8010231b:	66 90                	xchg   %ax,%ax
8010231d:	66 90                	xchg   %ax,%ax
8010231f:	90                   	nop

80102320 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102320:	55                   	push   %ebp
80102321:	89 e5                	mov    %esp,%ebp
80102323:	53                   	push   %ebx
80102324:	83 ec 04             	sub    $0x4,%esp
80102327:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010232a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102330:	75 70                	jne    801023a2 <kfree+0x82>
80102332:	81 fb a8 55 11 80    	cmp    $0x801155a8,%ebx
80102338:	72 68                	jb     801023a2 <kfree+0x82>
8010233a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102340:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102345:	77 5b                	ja     801023a2 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102347:	83 ec 04             	sub    $0x4,%esp
8010234a:	68 00 10 00 00       	push   $0x1000
8010234f:	6a 01                	push   $0x1
80102351:	53                   	push   %ebx
80102352:	e8 b9 22 00 00       	call   80104610 <memset>

  if(kmem.use_lock)
80102357:	8b 15 74 26 11 80    	mov    0x80112674,%edx
8010235d:	83 c4 10             	add    $0x10,%esp
80102360:	85 d2                	test   %edx,%edx
80102362:	75 2c                	jne    80102390 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102364:	a1 78 26 11 80       	mov    0x80112678,%eax
80102369:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010236b:	a1 74 26 11 80       	mov    0x80112674,%eax
  kmem.freelist = r;
80102370:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
80102376:	85 c0                	test   %eax,%eax
80102378:	75 06                	jne    80102380 <kfree+0x60>
    release(&kmem.lock);
}
8010237a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010237d:	c9                   	leave  
8010237e:	c3                   	ret    
8010237f:	90                   	nop
    release(&kmem.lock);
80102380:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
80102387:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010238a:	c9                   	leave  
    release(&kmem.lock);
8010238b:	e9 20 22 00 00       	jmp    801045b0 <release>
    acquire(&kmem.lock);
80102390:	83 ec 0c             	sub    $0xc,%esp
80102393:	68 40 26 11 80       	push   $0x80112640
80102398:	e8 f3 20 00 00       	call   80104490 <acquire>
8010239d:	83 c4 10             	add    $0x10,%esp
801023a0:	eb c2                	jmp    80102364 <kfree+0x44>
    panic("kfree");
801023a2:	83 ec 0c             	sub    $0xc,%esp
801023a5:	68 a6 73 10 80       	push   $0x801073a6
801023aa:	e8 e1 df ff ff       	call   80100390 <panic>
801023af:	90                   	nop

801023b0 <freerange>:
{
801023b0:	55                   	push   %ebp
801023b1:	89 e5                	mov    %esp,%ebp
801023b3:	56                   	push   %esi
801023b4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801023b5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801023b8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801023bb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023c1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023c7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023cd:	39 de                	cmp    %ebx,%esi
801023cf:	72 23                	jb     801023f4 <freerange+0x44>
801023d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801023d8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801023de:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023e1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801023e7:	50                   	push   %eax
801023e8:	e8 33 ff ff ff       	call   80102320 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023ed:	83 c4 10             	add    $0x10,%esp
801023f0:	39 f3                	cmp    %esi,%ebx
801023f2:	76 e4                	jbe    801023d8 <freerange+0x28>
}
801023f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023f7:	5b                   	pop    %ebx
801023f8:	5e                   	pop    %esi
801023f9:	5d                   	pop    %ebp
801023fa:	c3                   	ret    
801023fb:	90                   	nop
801023fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102400 <kinit1>:
{
80102400:	55                   	push   %ebp
80102401:	89 e5                	mov    %esp,%ebp
80102403:	56                   	push   %esi
80102404:	53                   	push   %ebx
80102405:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102408:	83 ec 08             	sub    $0x8,%esp
8010240b:	68 ac 73 10 80       	push   $0x801073ac
80102410:	68 40 26 11 80       	push   $0x80112640
80102415:	e8 86 1f 00 00       	call   801043a0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010241a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010241d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102420:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
80102427:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010242a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102430:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102436:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010243c:	39 de                	cmp    %ebx,%esi
8010243e:	72 1c                	jb     8010245c <kinit1+0x5c>
    kfree(p);
80102440:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102446:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102449:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010244f:	50                   	push   %eax
80102450:	e8 cb fe ff ff       	call   80102320 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102455:	83 c4 10             	add    $0x10,%esp
80102458:	39 de                	cmp    %ebx,%esi
8010245a:	73 e4                	jae    80102440 <kinit1+0x40>
}
8010245c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010245f:	5b                   	pop    %ebx
80102460:	5e                   	pop    %esi
80102461:	5d                   	pop    %ebp
80102462:	c3                   	ret    
80102463:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102470 <kinit2>:
{
80102470:	55                   	push   %ebp
80102471:	89 e5                	mov    %esp,%ebp
80102473:	56                   	push   %esi
80102474:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102475:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102478:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010247b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102481:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102487:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010248d:	39 de                	cmp    %ebx,%esi
8010248f:	72 23                	jb     801024b4 <kinit2+0x44>
80102491:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102498:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010249e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024a1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801024a7:	50                   	push   %eax
801024a8:	e8 73 fe ff ff       	call   80102320 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024ad:	83 c4 10             	add    $0x10,%esp
801024b0:	39 de                	cmp    %ebx,%esi
801024b2:	73 e4                	jae    80102498 <kinit2+0x28>
  kmem.use_lock = 1;
801024b4:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
801024bb:	00 00 00 
}
801024be:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024c1:	5b                   	pop    %ebx
801024c2:	5e                   	pop    %esi
801024c3:	5d                   	pop    %ebp
801024c4:	c3                   	ret    
801024c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024d0 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
801024d0:	a1 74 26 11 80       	mov    0x80112674,%eax
801024d5:	85 c0                	test   %eax,%eax
801024d7:	75 1f                	jne    801024f8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801024d9:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
801024de:	85 c0                	test   %eax,%eax
801024e0:	74 0e                	je     801024f0 <kalloc+0x20>
    kmem.freelist = r->next;
801024e2:	8b 10                	mov    (%eax),%edx
801024e4:	89 15 78 26 11 80    	mov    %edx,0x80112678
801024ea:	c3                   	ret    
801024eb:	90                   	nop
801024ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
801024f0:	f3 c3                	repz ret 
801024f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
801024f8:	55                   	push   %ebp
801024f9:	89 e5                	mov    %esp,%ebp
801024fb:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
801024fe:	68 40 26 11 80       	push   $0x80112640
80102503:	e8 88 1f 00 00       	call   80104490 <acquire>
  r = kmem.freelist;
80102508:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
8010250d:	83 c4 10             	add    $0x10,%esp
80102510:	8b 15 74 26 11 80    	mov    0x80112674,%edx
80102516:	85 c0                	test   %eax,%eax
80102518:	74 08                	je     80102522 <kalloc+0x52>
    kmem.freelist = r->next;
8010251a:	8b 08                	mov    (%eax),%ecx
8010251c:	89 0d 78 26 11 80    	mov    %ecx,0x80112678
  if(kmem.use_lock)
80102522:	85 d2                	test   %edx,%edx
80102524:	74 16                	je     8010253c <kalloc+0x6c>
    release(&kmem.lock);
80102526:	83 ec 0c             	sub    $0xc,%esp
80102529:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010252c:	68 40 26 11 80       	push   $0x80112640
80102531:	e8 7a 20 00 00       	call   801045b0 <release>
  return (char*)r;
80102536:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102539:	83 c4 10             	add    $0x10,%esp
}
8010253c:	c9                   	leave  
8010253d:	c3                   	ret    
8010253e:	66 90                	xchg   %ax,%ax

80102540 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102540:	ba 64 00 00 00       	mov    $0x64,%edx
80102545:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102546:	a8 01                	test   $0x1,%al
80102548:	0f 84 c2 00 00 00    	je     80102610 <kbdgetc+0xd0>
8010254e:	ba 60 00 00 00       	mov    $0x60,%edx
80102553:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102554:	0f b6 d0             	movzbl %al,%edx
80102557:	8b 0d b4 a5 10 80    	mov    0x8010a5b4,%ecx

  if(data == 0xE0){
8010255d:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102563:	0f 84 7f 00 00 00    	je     801025e8 <kbdgetc+0xa8>
{
80102569:	55                   	push   %ebp
8010256a:	89 e5                	mov    %esp,%ebp
8010256c:	53                   	push   %ebx
8010256d:	89 cb                	mov    %ecx,%ebx
8010256f:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102572:	84 c0                	test   %al,%al
80102574:	78 4a                	js     801025c0 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102576:	85 db                	test   %ebx,%ebx
80102578:	74 09                	je     80102583 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010257a:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
8010257d:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
80102580:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102583:	0f b6 82 e0 74 10 80 	movzbl -0x7fef8b20(%edx),%eax
8010258a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
8010258c:	0f b6 82 e0 73 10 80 	movzbl -0x7fef8c20(%edx),%eax
80102593:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102595:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102597:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
8010259d:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801025a0:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801025a3:	8b 04 85 c0 73 10 80 	mov    -0x7fef8c40(,%eax,4),%eax
801025aa:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
801025ae:	74 31                	je     801025e1 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
801025b0:	8d 50 9f             	lea    -0x61(%eax),%edx
801025b3:	83 fa 19             	cmp    $0x19,%edx
801025b6:	77 40                	ja     801025f8 <kbdgetc+0xb8>
      c += 'A' - 'a';
801025b8:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025bb:	5b                   	pop    %ebx
801025bc:	5d                   	pop    %ebp
801025bd:	c3                   	ret    
801025be:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
801025c0:	83 e0 7f             	and    $0x7f,%eax
801025c3:	85 db                	test   %ebx,%ebx
801025c5:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
801025c8:	0f b6 82 e0 74 10 80 	movzbl -0x7fef8b20(%edx),%eax
801025cf:	83 c8 40             	or     $0x40,%eax
801025d2:	0f b6 c0             	movzbl %al,%eax
801025d5:	f7 d0                	not    %eax
801025d7:	21 c1                	and    %eax,%ecx
    return 0;
801025d9:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801025db:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
}
801025e1:	5b                   	pop    %ebx
801025e2:	5d                   	pop    %ebp
801025e3:	c3                   	ret    
801025e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
801025e8:	83 c9 40             	or     $0x40,%ecx
    return 0;
801025eb:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801025ed:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
    return 0;
801025f3:	c3                   	ret    
801025f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
801025f8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801025fb:	8d 50 20             	lea    0x20(%eax),%edx
}
801025fe:	5b                   	pop    %ebx
      c += 'a' - 'A';
801025ff:	83 f9 1a             	cmp    $0x1a,%ecx
80102602:	0f 42 c2             	cmovb  %edx,%eax
}
80102605:	5d                   	pop    %ebp
80102606:	c3                   	ret    
80102607:	89 f6                	mov    %esi,%esi
80102609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102610:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102615:	c3                   	ret    
80102616:	8d 76 00             	lea    0x0(%esi),%esi
80102619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102620 <kbdintr>:

void
kbdintr(void)
{
80102620:	55                   	push   %ebp
80102621:	89 e5                	mov    %esp,%ebp
80102623:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102626:	68 40 25 10 80       	push   $0x80102540
8010262b:	e8 e0 e1 ff ff       	call   80100810 <consoleintr>
}
80102630:	83 c4 10             	add    $0x10,%esp
80102633:	c9                   	leave  
80102634:	c3                   	ret    
80102635:	66 90                	xchg   %ax,%ax
80102637:	66 90                	xchg   %ax,%ax
80102639:	66 90                	xchg   %ax,%ax
8010263b:	66 90                	xchg   %ax,%ax
8010263d:	66 90                	xchg   %ax,%ax
8010263f:	90                   	nop

80102640 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102640:	a1 7c 26 11 80       	mov    0x8011267c,%eax
{
80102645:	55                   	push   %ebp
80102646:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102648:	85 c0                	test   %eax,%eax
8010264a:	0f 84 c8 00 00 00    	je     80102718 <lapicinit+0xd8>
  lapic[index] = value;
80102650:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102657:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010265a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010265d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102664:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102667:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010266a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102671:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102674:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102677:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010267e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102681:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102684:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010268b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010268e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102691:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102698:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010269b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010269e:	8b 50 30             	mov    0x30(%eax),%edx
801026a1:	c1 ea 10             	shr    $0x10,%edx
801026a4:	80 fa 03             	cmp    $0x3,%dl
801026a7:	77 77                	ja     80102720 <lapicinit+0xe0>
  lapic[index] = value;
801026a9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801026b0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026b3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026b6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026bd:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026c0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026c3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026ca:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026cd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026d0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801026d7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026da:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026dd:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801026e4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026e7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026ea:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801026f1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801026f4:	8b 50 20             	mov    0x20(%eax),%edx
801026f7:	89 f6                	mov    %esi,%esi
801026f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102700:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102706:	80 e6 10             	and    $0x10,%dh
80102709:	75 f5                	jne    80102700 <lapicinit+0xc0>
  lapic[index] = value;
8010270b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102712:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102715:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102718:	5d                   	pop    %ebp
80102719:	c3                   	ret    
8010271a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102720:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102727:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010272a:	8b 50 20             	mov    0x20(%eax),%edx
8010272d:	e9 77 ff ff ff       	jmp    801026a9 <lapicinit+0x69>
80102732:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102740 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102740:	8b 15 7c 26 11 80    	mov    0x8011267c,%edx
{
80102746:	55                   	push   %ebp
80102747:	31 c0                	xor    %eax,%eax
80102749:	89 e5                	mov    %esp,%ebp
  if (!lapic)
8010274b:	85 d2                	test   %edx,%edx
8010274d:	74 06                	je     80102755 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
8010274f:	8b 42 20             	mov    0x20(%edx),%eax
80102752:	c1 e8 18             	shr    $0x18,%eax
}
80102755:	5d                   	pop    %ebp
80102756:	c3                   	ret    
80102757:	89 f6                	mov    %esi,%esi
80102759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102760 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102760:	a1 7c 26 11 80       	mov    0x8011267c,%eax
{
80102765:	55                   	push   %ebp
80102766:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102768:	85 c0                	test   %eax,%eax
8010276a:	74 0d                	je     80102779 <lapiceoi+0x19>
  lapic[index] = value;
8010276c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102773:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102776:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102779:	5d                   	pop    %ebp
8010277a:	c3                   	ret    
8010277b:	90                   	nop
8010277c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102780 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102780:	55                   	push   %ebp
80102781:	89 e5                	mov    %esp,%ebp
}
80102783:	5d                   	pop    %ebp
80102784:	c3                   	ret    
80102785:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102790 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102790:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102791:	b8 0f 00 00 00       	mov    $0xf,%eax
80102796:	ba 70 00 00 00       	mov    $0x70,%edx
8010279b:	89 e5                	mov    %esp,%ebp
8010279d:	53                   	push   %ebx
8010279e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801027a1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801027a4:	ee                   	out    %al,(%dx)
801027a5:	b8 0a 00 00 00       	mov    $0xa,%eax
801027aa:	ba 71 00 00 00       	mov    $0x71,%edx
801027af:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801027b0:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
801027b2:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
801027b5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
801027bb:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801027bd:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
801027c0:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
801027c3:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
801027c5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
801027c8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
801027ce:	a1 7c 26 11 80       	mov    0x8011267c,%eax
801027d3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027d9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027dc:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801027e3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027e6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027e9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801027f0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027f3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027f6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027fc:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027ff:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102805:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102808:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010280e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102811:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102817:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
8010281a:	5b                   	pop    %ebx
8010281b:	5d                   	pop    %ebp
8010281c:	c3                   	ret    
8010281d:	8d 76 00             	lea    0x0(%esi),%esi

80102820 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
80102820:	55                   	push   %ebp
80102821:	b8 0b 00 00 00       	mov    $0xb,%eax
80102826:	ba 70 00 00 00       	mov    $0x70,%edx
8010282b:	89 e5                	mov    %esp,%ebp
8010282d:	57                   	push   %edi
8010282e:	56                   	push   %esi
8010282f:	53                   	push   %ebx
80102830:	83 ec 4c             	sub    $0x4c,%esp
80102833:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102834:	ba 71 00 00 00       	mov    $0x71,%edx
80102839:	ec                   	in     (%dx),%al
8010283a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010283d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102842:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102845:	8d 76 00             	lea    0x0(%esi),%esi
80102848:	31 c0                	xor    %eax,%eax
8010284a:	89 da                	mov    %ebx,%edx
8010284c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010284d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102852:	89 ca                	mov    %ecx,%edx
80102854:	ec                   	in     (%dx),%al
80102855:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102858:	89 da                	mov    %ebx,%edx
8010285a:	b8 02 00 00 00       	mov    $0x2,%eax
8010285f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102860:	89 ca                	mov    %ecx,%edx
80102862:	ec                   	in     (%dx),%al
80102863:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102866:	89 da                	mov    %ebx,%edx
80102868:	b8 04 00 00 00       	mov    $0x4,%eax
8010286d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010286e:	89 ca                	mov    %ecx,%edx
80102870:	ec                   	in     (%dx),%al
80102871:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102874:	89 da                	mov    %ebx,%edx
80102876:	b8 07 00 00 00       	mov    $0x7,%eax
8010287b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010287c:	89 ca                	mov    %ecx,%edx
8010287e:	ec                   	in     (%dx),%al
8010287f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102882:	89 da                	mov    %ebx,%edx
80102884:	b8 08 00 00 00       	mov    $0x8,%eax
80102889:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010288a:	89 ca                	mov    %ecx,%edx
8010288c:	ec                   	in     (%dx),%al
8010288d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010288f:	89 da                	mov    %ebx,%edx
80102891:	b8 09 00 00 00       	mov    $0x9,%eax
80102896:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102897:	89 ca                	mov    %ecx,%edx
80102899:	ec                   	in     (%dx),%al
8010289a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010289c:	89 da                	mov    %ebx,%edx
8010289e:	b8 0a 00 00 00       	mov    $0xa,%eax
801028a3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028a4:	89 ca                	mov    %ecx,%edx
801028a6:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
801028a7:	84 c0                	test   %al,%al
801028a9:	78 9d                	js     80102848 <cmostime+0x28>
  return inb(CMOS_RETURN);
801028ab:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
801028af:	89 fa                	mov    %edi,%edx
801028b1:	0f b6 fa             	movzbl %dl,%edi
801028b4:	89 f2                	mov    %esi,%edx
801028b6:	0f b6 f2             	movzbl %dl,%esi
801028b9:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028bc:	89 da                	mov    %ebx,%edx
801028be:	89 75 cc             	mov    %esi,-0x34(%ebp)
801028c1:	89 45 b8             	mov    %eax,-0x48(%ebp)
801028c4:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
801028c8:	89 45 bc             	mov    %eax,-0x44(%ebp)
801028cb:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
801028cf:	89 45 c0             	mov    %eax,-0x40(%ebp)
801028d2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
801028d6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801028d9:	31 c0                	xor    %eax,%eax
801028db:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028dc:	89 ca                	mov    %ecx,%edx
801028de:	ec                   	in     (%dx),%al
801028df:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028e2:	89 da                	mov    %ebx,%edx
801028e4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801028e7:	b8 02 00 00 00       	mov    $0x2,%eax
801028ec:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028ed:	89 ca                	mov    %ecx,%edx
801028ef:	ec                   	in     (%dx),%al
801028f0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028f3:	89 da                	mov    %ebx,%edx
801028f5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801028f8:	b8 04 00 00 00       	mov    $0x4,%eax
801028fd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028fe:	89 ca                	mov    %ecx,%edx
80102900:	ec                   	in     (%dx),%al
80102901:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102904:	89 da                	mov    %ebx,%edx
80102906:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102909:	b8 07 00 00 00       	mov    $0x7,%eax
8010290e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010290f:	89 ca                	mov    %ecx,%edx
80102911:	ec                   	in     (%dx),%al
80102912:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102915:	89 da                	mov    %ebx,%edx
80102917:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010291a:	b8 08 00 00 00       	mov    $0x8,%eax
8010291f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102920:	89 ca                	mov    %ecx,%edx
80102922:	ec                   	in     (%dx),%al
80102923:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102926:	89 da                	mov    %ebx,%edx
80102928:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010292b:	b8 09 00 00 00       	mov    $0x9,%eax
80102930:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102931:	89 ca                	mov    %ecx,%edx
80102933:	ec                   	in     (%dx),%al
80102934:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102937:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
8010293a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010293d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102940:	6a 18                	push   $0x18
80102942:	50                   	push   %eax
80102943:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102946:	50                   	push   %eax
80102947:	e8 14 1d 00 00       	call   80104660 <memcmp>
8010294c:	83 c4 10             	add    $0x10,%esp
8010294f:	85 c0                	test   %eax,%eax
80102951:	0f 85 f1 fe ff ff    	jne    80102848 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102957:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
8010295b:	75 78                	jne    801029d5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010295d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102960:	89 c2                	mov    %eax,%edx
80102962:	83 e0 0f             	and    $0xf,%eax
80102965:	c1 ea 04             	shr    $0x4,%edx
80102968:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010296b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010296e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102971:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102974:	89 c2                	mov    %eax,%edx
80102976:	83 e0 0f             	and    $0xf,%eax
80102979:	c1 ea 04             	shr    $0x4,%edx
8010297c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010297f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102982:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102985:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102988:	89 c2                	mov    %eax,%edx
8010298a:	83 e0 0f             	and    $0xf,%eax
8010298d:	c1 ea 04             	shr    $0x4,%edx
80102990:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102993:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102996:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102999:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010299c:	89 c2                	mov    %eax,%edx
8010299e:	83 e0 0f             	and    $0xf,%eax
801029a1:	c1 ea 04             	shr    $0x4,%edx
801029a4:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029a7:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029aa:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
801029ad:	8b 45 c8             	mov    -0x38(%ebp),%eax
801029b0:	89 c2                	mov    %eax,%edx
801029b2:	83 e0 0f             	and    $0xf,%eax
801029b5:	c1 ea 04             	shr    $0x4,%edx
801029b8:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029bb:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029be:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
801029c1:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029c4:	89 c2                	mov    %eax,%edx
801029c6:	83 e0 0f             	and    $0xf,%eax
801029c9:	c1 ea 04             	shr    $0x4,%edx
801029cc:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029cf:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029d2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
801029d5:	8b 75 08             	mov    0x8(%ebp),%esi
801029d8:	8b 45 b8             	mov    -0x48(%ebp),%eax
801029db:	89 06                	mov    %eax,(%esi)
801029dd:	8b 45 bc             	mov    -0x44(%ebp),%eax
801029e0:	89 46 04             	mov    %eax,0x4(%esi)
801029e3:	8b 45 c0             	mov    -0x40(%ebp),%eax
801029e6:	89 46 08             	mov    %eax,0x8(%esi)
801029e9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801029ec:	89 46 0c             	mov    %eax,0xc(%esi)
801029ef:	8b 45 c8             	mov    -0x38(%ebp),%eax
801029f2:	89 46 10             	mov    %eax,0x10(%esi)
801029f5:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029f8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
801029fb:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102a02:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a05:	5b                   	pop    %ebx
80102a06:	5e                   	pop    %esi
80102a07:	5f                   	pop    %edi
80102a08:	5d                   	pop    %ebp
80102a09:	c3                   	ret    
80102a0a:	66 90                	xchg   %ax,%ax
80102a0c:	66 90                	xchg   %ax,%ax
80102a0e:	66 90                	xchg   %ax,%ax

80102a10 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a10:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102a16:	85 c9                	test   %ecx,%ecx
80102a18:	0f 8e 8a 00 00 00    	jle    80102aa8 <install_trans+0x98>
{
80102a1e:	55                   	push   %ebp
80102a1f:	89 e5                	mov    %esp,%ebp
80102a21:	57                   	push   %edi
80102a22:	56                   	push   %esi
80102a23:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102a24:	31 db                	xor    %ebx,%ebx
{
80102a26:	83 ec 0c             	sub    $0xc,%esp
80102a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102a30:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102a35:	83 ec 08             	sub    $0x8,%esp
80102a38:	01 d8                	add    %ebx,%eax
80102a3a:	83 c0 01             	add    $0x1,%eax
80102a3d:	50                   	push   %eax
80102a3e:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102a44:	e8 87 d6 ff ff       	call   801000d0 <bread>
80102a49:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a4b:	58                   	pop    %eax
80102a4c:	5a                   	pop    %edx
80102a4d:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102a54:	ff 35 c4 26 11 80    	pushl  0x801126c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102a5a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a5d:	e8 6e d6 ff ff       	call   801000d0 <bread>
80102a62:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102a64:	8d 47 5c             	lea    0x5c(%edi),%eax
80102a67:	83 c4 0c             	add    $0xc,%esp
80102a6a:	68 00 02 00 00       	push   $0x200
80102a6f:	50                   	push   %eax
80102a70:	8d 46 5c             	lea    0x5c(%esi),%eax
80102a73:	50                   	push   %eax
80102a74:	e8 47 1c 00 00       	call   801046c0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102a79:	89 34 24             	mov    %esi,(%esp)
80102a7c:	e8 1f d7 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102a81:	89 3c 24             	mov    %edi,(%esp)
80102a84:	e8 57 d7 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102a89:	89 34 24             	mov    %esi,(%esp)
80102a8c:	e8 4f d7 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102a91:	83 c4 10             	add    $0x10,%esp
80102a94:	39 1d c8 26 11 80    	cmp    %ebx,0x801126c8
80102a9a:	7f 94                	jg     80102a30 <install_trans+0x20>
  }
}
80102a9c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a9f:	5b                   	pop    %ebx
80102aa0:	5e                   	pop    %esi
80102aa1:	5f                   	pop    %edi
80102aa2:	5d                   	pop    %ebp
80102aa3:	c3                   	ret    
80102aa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102aa8:	f3 c3                	repz ret 
80102aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102ab0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102ab0:	55                   	push   %ebp
80102ab1:	89 e5                	mov    %esp,%ebp
80102ab3:	56                   	push   %esi
80102ab4:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80102ab5:	83 ec 08             	sub    $0x8,%esp
80102ab8:	ff 35 b4 26 11 80    	pushl  0x801126b4
80102abe:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102ac4:	e8 07 d6 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102ac9:	8b 1d c8 26 11 80    	mov    0x801126c8,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102acf:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102ad2:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80102ad4:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80102ad6:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102ad9:	7e 16                	jle    80102af1 <write_head+0x41>
80102adb:	c1 e3 02             	shl    $0x2,%ebx
80102ade:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102ae0:	8b 8a cc 26 11 80    	mov    -0x7feed934(%edx),%ecx
80102ae6:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102aea:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102aed:	39 da                	cmp    %ebx,%edx
80102aef:	75 ef                	jne    80102ae0 <write_head+0x30>
  }
  bwrite(buf);
80102af1:	83 ec 0c             	sub    $0xc,%esp
80102af4:	56                   	push   %esi
80102af5:	e8 a6 d6 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102afa:	89 34 24             	mov    %esi,(%esp)
80102afd:	e8 de d6 ff ff       	call   801001e0 <brelse>
}
80102b02:	83 c4 10             	add    $0x10,%esp
80102b05:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102b08:	5b                   	pop    %ebx
80102b09:	5e                   	pop    %esi
80102b0a:	5d                   	pop    %ebp
80102b0b:	c3                   	ret    
80102b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102b10 <initlog>:
{
80102b10:	55                   	push   %ebp
80102b11:	89 e5                	mov    %esp,%ebp
80102b13:	53                   	push   %ebx
80102b14:	83 ec 2c             	sub    $0x2c,%esp
80102b17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102b1a:	68 e0 75 10 80       	push   $0x801075e0
80102b1f:	68 80 26 11 80       	push   $0x80112680
80102b24:	e8 77 18 00 00       	call   801043a0 <initlock>
  readsb(dev, &sb);
80102b29:	58                   	pop    %eax
80102b2a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102b2d:	5a                   	pop    %edx
80102b2e:	50                   	push   %eax
80102b2f:	53                   	push   %ebx
80102b30:	e8 9b e8 ff ff       	call   801013d0 <readsb>
  log.size = sb.nlog;
80102b35:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102b38:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102b3b:	59                   	pop    %ecx
  log.dev = dev;
80102b3c:	89 1d c4 26 11 80    	mov    %ebx,0x801126c4
  log.size = sb.nlog;
80102b42:	89 15 b8 26 11 80    	mov    %edx,0x801126b8
  log.start = sb.logstart;
80102b48:	a3 b4 26 11 80       	mov    %eax,0x801126b4
  struct buf *buf = bread(log.dev, log.start);
80102b4d:	5a                   	pop    %edx
80102b4e:	50                   	push   %eax
80102b4f:	53                   	push   %ebx
80102b50:	e8 7b d5 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102b55:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102b58:	83 c4 10             	add    $0x10,%esp
80102b5b:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102b5d:	89 1d c8 26 11 80    	mov    %ebx,0x801126c8
  for (i = 0; i < log.lh.n; i++) {
80102b63:	7e 1c                	jle    80102b81 <initlog+0x71>
80102b65:	c1 e3 02             	shl    $0x2,%ebx
80102b68:	31 d2                	xor    %edx,%edx
80102b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102b70:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102b74:	83 c2 04             	add    $0x4,%edx
80102b77:	89 8a c8 26 11 80    	mov    %ecx,-0x7feed938(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102b7d:	39 d3                	cmp    %edx,%ebx
80102b7f:	75 ef                	jne    80102b70 <initlog+0x60>
  brelse(buf);
80102b81:	83 ec 0c             	sub    $0xc,%esp
80102b84:	50                   	push   %eax
80102b85:	e8 56 d6 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102b8a:	e8 81 fe ff ff       	call   80102a10 <install_trans>
  log.lh.n = 0;
80102b8f:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102b96:	00 00 00 
  write_head(); // clear the log
80102b99:	e8 12 ff ff ff       	call   80102ab0 <write_head>
}
80102b9e:	83 c4 10             	add    $0x10,%esp
80102ba1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102ba4:	c9                   	leave  
80102ba5:	c3                   	ret    
80102ba6:	8d 76 00             	lea    0x0(%esi),%esi
80102ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102bb0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102bb0:	55                   	push   %ebp
80102bb1:	89 e5                	mov    %esp,%ebp
80102bb3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102bb6:	68 80 26 11 80       	push   $0x80112680
80102bbb:	e8 d0 18 00 00       	call   80104490 <acquire>
80102bc0:	83 c4 10             	add    $0x10,%esp
80102bc3:	eb 18                	jmp    80102bdd <begin_op+0x2d>
80102bc5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102bc8:	83 ec 08             	sub    $0x8,%esp
80102bcb:	68 80 26 11 80       	push   $0x80112680
80102bd0:	68 80 26 11 80       	push   $0x80112680
80102bd5:	e8 e6 11 00 00       	call   80103dc0 <sleep>
80102bda:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102bdd:	a1 c0 26 11 80       	mov    0x801126c0,%eax
80102be2:	85 c0                	test   %eax,%eax
80102be4:	75 e2                	jne    80102bc8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102be6:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102beb:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102bf1:	83 c0 01             	add    $0x1,%eax
80102bf4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102bf7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102bfa:	83 fa 1e             	cmp    $0x1e,%edx
80102bfd:	7f c9                	jg     80102bc8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102bff:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102c02:	a3 bc 26 11 80       	mov    %eax,0x801126bc
      release(&log.lock);
80102c07:	68 80 26 11 80       	push   $0x80112680
80102c0c:	e8 9f 19 00 00       	call   801045b0 <release>
      break;
    }
  }
}
80102c11:	83 c4 10             	add    $0x10,%esp
80102c14:	c9                   	leave  
80102c15:	c3                   	ret    
80102c16:	8d 76 00             	lea    0x0(%esi),%esi
80102c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c20 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102c20:	55                   	push   %ebp
80102c21:	89 e5                	mov    %esp,%ebp
80102c23:	57                   	push   %edi
80102c24:	56                   	push   %esi
80102c25:	53                   	push   %ebx
80102c26:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102c29:	68 80 26 11 80       	push   $0x80112680
80102c2e:	e8 5d 18 00 00       	call   80104490 <acquire>
  log.outstanding -= 1;
80102c33:	a1 bc 26 11 80       	mov    0x801126bc,%eax
  if(log.committing)
80102c38:	8b 35 c0 26 11 80    	mov    0x801126c0,%esi
80102c3e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102c41:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102c44:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102c46:	89 1d bc 26 11 80    	mov    %ebx,0x801126bc
  if(log.committing)
80102c4c:	0f 85 1a 01 00 00    	jne    80102d6c <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80102c52:	85 db                	test   %ebx,%ebx
80102c54:	0f 85 ee 00 00 00    	jne    80102d48 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102c5a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
80102c5d:	c7 05 c0 26 11 80 01 	movl   $0x1,0x801126c0
80102c64:	00 00 00 
  release(&log.lock);
80102c67:	68 80 26 11 80       	push   $0x80112680
80102c6c:	e8 3f 19 00 00       	call   801045b0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c71:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102c77:	83 c4 10             	add    $0x10,%esp
80102c7a:	85 c9                	test   %ecx,%ecx
80102c7c:	0f 8e 85 00 00 00    	jle    80102d07 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102c82:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102c87:	83 ec 08             	sub    $0x8,%esp
80102c8a:	01 d8                	add    %ebx,%eax
80102c8c:	83 c0 01             	add    $0x1,%eax
80102c8f:	50                   	push   %eax
80102c90:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102c96:	e8 35 d4 ff ff       	call   801000d0 <bread>
80102c9b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c9d:	58                   	pop    %eax
80102c9e:	5a                   	pop    %edx
80102c9f:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102ca6:	ff 35 c4 26 11 80    	pushl  0x801126c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102cac:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102caf:	e8 1c d4 ff ff       	call   801000d0 <bread>
80102cb4:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102cb6:	8d 40 5c             	lea    0x5c(%eax),%eax
80102cb9:	83 c4 0c             	add    $0xc,%esp
80102cbc:	68 00 02 00 00       	push   $0x200
80102cc1:	50                   	push   %eax
80102cc2:	8d 46 5c             	lea    0x5c(%esi),%eax
80102cc5:	50                   	push   %eax
80102cc6:	e8 f5 19 00 00       	call   801046c0 <memmove>
    bwrite(to);  // write the log
80102ccb:	89 34 24             	mov    %esi,(%esp)
80102cce:	e8 cd d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102cd3:	89 3c 24             	mov    %edi,(%esp)
80102cd6:	e8 05 d5 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102cdb:	89 34 24             	mov    %esi,(%esp)
80102cde:	e8 fd d4 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102ce3:	83 c4 10             	add    $0x10,%esp
80102ce6:	3b 1d c8 26 11 80    	cmp    0x801126c8,%ebx
80102cec:	7c 94                	jl     80102c82 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102cee:	e8 bd fd ff ff       	call   80102ab0 <write_head>
    install_trans(); // Now install writes to home locations
80102cf3:	e8 18 fd ff ff       	call   80102a10 <install_trans>
    log.lh.n = 0;
80102cf8:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102cff:	00 00 00 
    write_head();    // Erase the transaction from the log
80102d02:	e8 a9 fd ff ff       	call   80102ab0 <write_head>
    acquire(&log.lock);
80102d07:	83 ec 0c             	sub    $0xc,%esp
80102d0a:	68 80 26 11 80       	push   $0x80112680
80102d0f:	e8 7c 17 00 00       	call   80104490 <acquire>
    wakeup(&log);
80102d14:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
    log.committing = 0;
80102d1b:	c7 05 c0 26 11 80 00 	movl   $0x0,0x801126c0
80102d22:	00 00 00 
    wakeup(&log);
80102d25:	e8 46 12 00 00       	call   80103f70 <wakeup>
    release(&log.lock);
80102d2a:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102d31:	e8 7a 18 00 00       	call   801045b0 <release>
80102d36:	83 c4 10             	add    $0x10,%esp
}
80102d39:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d3c:	5b                   	pop    %ebx
80102d3d:	5e                   	pop    %esi
80102d3e:	5f                   	pop    %edi
80102d3f:	5d                   	pop    %ebp
80102d40:	c3                   	ret    
80102d41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80102d48:	83 ec 0c             	sub    $0xc,%esp
80102d4b:	68 80 26 11 80       	push   $0x80112680
80102d50:	e8 1b 12 00 00       	call   80103f70 <wakeup>
  release(&log.lock);
80102d55:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102d5c:	e8 4f 18 00 00       	call   801045b0 <release>
80102d61:	83 c4 10             	add    $0x10,%esp
}
80102d64:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d67:	5b                   	pop    %ebx
80102d68:	5e                   	pop    %esi
80102d69:	5f                   	pop    %edi
80102d6a:	5d                   	pop    %ebp
80102d6b:	c3                   	ret    
    panic("log.committing");
80102d6c:	83 ec 0c             	sub    $0xc,%esp
80102d6f:	68 e4 75 10 80       	push   $0x801075e4
80102d74:	e8 17 d6 ff ff       	call   80100390 <panic>
80102d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102d80 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d80:	55                   	push   %ebp
80102d81:	89 e5                	mov    %esp,%ebp
80102d83:	53                   	push   %ebx
80102d84:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d87:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
{
80102d8d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d90:	83 fa 1d             	cmp    $0x1d,%edx
80102d93:	0f 8f 9d 00 00 00    	jg     80102e36 <log_write+0xb6>
80102d99:	a1 b8 26 11 80       	mov    0x801126b8,%eax
80102d9e:	83 e8 01             	sub    $0x1,%eax
80102da1:	39 c2                	cmp    %eax,%edx
80102da3:	0f 8d 8d 00 00 00    	jge    80102e36 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102da9:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102dae:	85 c0                	test   %eax,%eax
80102db0:	0f 8e 8d 00 00 00    	jle    80102e43 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102db6:	83 ec 0c             	sub    $0xc,%esp
80102db9:	68 80 26 11 80       	push   $0x80112680
80102dbe:	e8 cd 16 00 00       	call   80104490 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102dc3:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102dc9:	83 c4 10             	add    $0x10,%esp
80102dcc:	83 f9 00             	cmp    $0x0,%ecx
80102dcf:	7e 57                	jle    80102e28 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102dd1:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102dd4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102dd6:	3b 15 cc 26 11 80    	cmp    0x801126cc,%edx
80102ddc:	75 0b                	jne    80102de9 <log_write+0x69>
80102dde:	eb 38                	jmp    80102e18 <log_write+0x98>
80102de0:	39 14 85 cc 26 11 80 	cmp    %edx,-0x7feed934(,%eax,4)
80102de7:	74 2f                	je     80102e18 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102de9:	83 c0 01             	add    $0x1,%eax
80102dec:	39 c1                	cmp    %eax,%ecx
80102dee:	75 f0                	jne    80102de0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102df0:	89 14 85 cc 26 11 80 	mov    %edx,-0x7feed934(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102df7:	83 c0 01             	add    $0x1,%eax
80102dfa:	a3 c8 26 11 80       	mov    %eax,0x801126c8
  b->flags |= B_DIRTY; // prevent eviction
80102dff:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102e02:	c7 45 08 80 26 11 80 	movl   $0x80112680,0x8(%ebp)
}
80102e09:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e0c:	c9                   	leave  
  release(&log.lock);
80102e0d:	e9 9e 17 00 00       	jmp    801045b0 <release>
80102e12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102e18:	89 14 85 cc 26 11 80 	mov    %edx,-0x7feed934(,%eax,4)
80102e1f:	eb de                	jmp    80102dff <log_write+0x7f>
80102e21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e28:	8b 43 08             	mov    0x8(%ebx),%eax
80102e2b:	a3 cc 26 11 80       	mov    %eax,0x801126cc
  if (i == log.lh.n)
80102e30:	75 cd                	jne    80102dff <log_write+0x7f>
80102e32:	31 c0                	xor    %eax,%eax
80102e34:	eb c1                	jmp    80102df7 <log_write+0x77>
    panic("too big a transaction");
80102e36:	83 ec 0c             	sub    $0xc,%esp
80102e39:	68 f3 75 10 80       	push   $0x801075f3
80102e3e:	e8 4d d5 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80102e43:	83 ec 0c             	sub    $0xc,%esp
80102e46:	68 09 76 10 80       	push   $0x80107609
80102e4b:	e8 40 d5 ff ff       	call   80100390 <panic>

80102e50 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102e50:	55                   	push   %ebp
80102e51:	89 e5                	mov    %esp,%ebp
80102e53:	53                   	push   %ebx
80102e54:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102e57:	e8 84 09 00 00       	call   801037e0 <cpuid>
80102e5c:	89 c3                	mov    %eax,%ebx
80102e5e:	e8 7d 09 00 00       	call   801037e0 <cpuid>
80102e63:	83 ec 04             	sub    $0x4,%esp
80102e66:	53                   	push   %ebx
80102e67:	50                   	push   %eax
80102e68:	68 24 76 10 80       	push   $0x80107624
80102e6d:	e8 ee d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102e72:	e8 f9 2a 00 00       	call   80105970 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102e77:	e8 e4 08 00 00       	call   80103760 <mycpu>
80102e7c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e7e:	b8 01 00 00 00       	mov    $0x1,%eax
80102e83:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102e8a:	e8 31 0c 00 00       	call   80103ac0 <scheduler>
80102e8f:	90                   	nop

80102e90 <mpenter>:
{
80102e90:	55                   	push   %ebp
80102e91:	89 e5                	mov    %esp,%ebp
80102e93:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102e96:	e8 c5 3b 00 00       	call   80106a60 <switchkvm>
  seginit();
80102e9b:	e8 30 3b 00 00       	call   801069d0 <seginit>
  lapicinit();
80102ea0:	e8 9b f7 ff ff       	call   80102640 <lapicinit>
  mpmain();
80102ea5:	e8 a6 ff ff ff       	call   80102e50 <mpmain>
80102eaa:	66 90                	xchg   %ax,%ax
80102eac:	66 90                	xchg   %ax,%ax
80102eae:	66 90                	xchg   %ax,%ax

80102eb0 <main>:
{
80102eb0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102eb4:	83 e4 f0             	and    $0xfffffff0,%esp
80102eb7:	ff 71 fc             	pushl  -0x4(%ecx)
80102eba:	55                   	push   %ebp
80102ebb:	89 e5                	mov    %esp,%ebp
80102ebd:	53                   	push   %ebx
80102ebe:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102ebf:	83 ec 08             	sub    $0x8,%esp
80102ec2:	68 00 00 40 80       	push   $0x80400000
80102ec7:	68 a8 55 11 80       	push   $0x801155a8
80102ecc:	e8 2f f5 ff ff       	call   80102400 <kinit1>
  kvmalloc();      // kernel page table
80102ed1:	e8 5a 40 00 00       	call   80106f30 <kvmalloc>
  mpinit();        // detect other processors
80102ed6:	e8 75 01 00 00       	call   80103050 <mpinit>
  lapicinit();     // interrupt controller
80102edb:	e8 60 f7 ff ff       	call   80102640 <lapicinit>
  seginit();       // segment descriptors
80102ee0:	e8 eb 3a 00 00       	call   801069d0 <seginit>
  picinit();       // disable pic
80102ee5:	e8 46 03 00 00       	call   80103230 <picinit>
  ioapicinit();    // another interrupt controller
80102eea:	e8 41 f3 ff ff       	call   80102230 <ioapicinit>
  consoleinit();   // console hardware
80102eef:	e8 cc da ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
80102ef4:	e8 a7 2d 00 00       	call   80105ca0 <uartinit>
  pinit();         // process table
80102ef9:	e8 42 08 00 00       	call   80103740 <pinit>
  tvinit();        // trap vectors
80102efe:	e8 ed 29 00 00       	call   801058f0 <tvinit>
  binit();         // buffer cache
80102f03:	e8 38 d1 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102f08:	e8 53 de ff ff       	call   80100d60 <fileinit>
  ideinit();       // disk 
80102f0d:	e8 fe f0 ff ff       	call   80102010 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102f12:	83 c4 0c             	add    $0xc,%esp
80102f15:	68 8a 00 00 00       	push   $0x8a
80102f1a:	68 8c a4 10 80       	push   $0x8010a48c
80102f1f:	68 00 70 00 80       	push   $0x80007000
80102f24:	e8 97 17 00 00       	call   801046c0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102f29:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80102f30:	00 00 00 
80102f33:	83 c4 10             	add    $0x10,%esp
80102f36:	05 80 27 11 80       	add    $0x80112780,%eax
80102f3b:	3d 80 27 11 80       	cmp    $0x80112780,%eax
80102f40:	76 71                	jbe    80102fb3 <main+0x103>
80102f42:	bb 80 27 11 80       	mov    $0x80112780,%ebx
80102f47:	89 f6                	mov    %esi,%esi
80102f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80102f50:	e8 0b 08 00 00       	call   80103760 <mycpu>
80102f55:	39 d8                	cmp    %ebx,%eax
80102f57:	74 41                	je     80102f9a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102f59:	e8 72 f5 ff ff       	call   801024d0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f5e:	05 00 10 00 00       	add    $0x1000,%eax
    *(void**)(code-8) = mpenter;
80102f63:	c7 05 f8 6f 00 80 90 	movl   $0x80102e90,0x80006ff8
80102f6a:	2e 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102f6d:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102f74:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f77:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
80102f7c:	0f b6 03             	movzbl (%ebx),%eax
80102f7f:	83 ec 08             	sub    $0x8,%esp
80102f82:	68 00 70 00 00       	push   $0x7000
80102f87:	50                   	push   %eax
80102f88:	e8 03 f8 ff ff       	call   80102790 <lapicstartap>
80102f8d:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102f90:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102f96:	85 c0                	test   %eax,%eax
80102f98:	74 f6                	je     80102f90 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
80102f9a:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80102fa1:	00 00 00 
80102fa4:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102faa:	05 80 27 11 80       	add    $0x80112780,%eax
80102faf:	39 c3                	cmp    %eax,%ebx
80102fb1:	72 9d                	jb     80102f50 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102fb3:	83 ec 08             	sub    $0x8,%esp
80102fb6:	68 00 00 00 8e       	push   $0x8e000000
80102fbb:	68 00 00 40 80       	push   $0x80400000
80102fc0:	e8 ab f4 ff ff       	call   80102470 <kinit2>
  userinit();      // first user process
80102fc5:	e8 66 08 00 00       	call   80103830 <userinit>
  mpmain();        // finish this processor's setup
80102fca:	e8 81 fe ff ff       	call   80102e50 <mpmain>
80102fcf:	90                   	nop

80102fd0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fd0:	55                   	push   %ebp
80102fd1:	89 e5                	mov    %esp,%ebp
80102fd3:	57                   	push   %edi
80102fd4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80102fd5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
80102fdb:	53                   	push   %ebx
  e = addr+len;
80102fdc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
80102fdf:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80102fe2:	39 de                	cmp    %ebx,%esi
80102fe4:	72 10                	jb     80102ff6 <mpsearch1+0x26>
80102fe6:	eb 50                	jmp    80103038 <mpsearch1+0x68>
80102fe8:	90                   	nop
80102fe9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ff0:	39 fb                	cmp    %edi,%ebx
80102ff2:	89 fe                	mov    %edi,%esi
80102ff4:	76 42                	jbe    80103038 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102ff6:	83 ec 04             	sub    $0x4,%esp
80102ff9:	8d 7e 10             	lea    0x10(%esi),%edi
80102ffc:	6a 04                	push   $0x4
80102ffe:	68 38 76 10 80       	push   $0x80107638
80103003:	56                   	push   %esi
80103004:	e8 57 16 00 00       	call   80104660 <memcmp>
80103009:	83 c4 10             	add    $0x10,%esp
8010300c:	85 c0                	test   %eax,%eax
8010300e:	75 e0                	jne    80102ff0 <mpsearch1+0x20>
80103010:	89 f1                	mov    %esi,%ecx
80103012:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103018:	0f b6 11             	movzbl (%ecx),%edx
8010301b:	83 c1 01             	add    $0x1,%ecx
8010301e:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
80103020:	39 f9                	cmp    %edi,%ecx
80103022:	75 f4                	jne    80103018 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103024:	84 c0                	test   %al,%al
80103026:	75 c8                	jne    80102ff0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103028:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010302b:	89 f0                	mov    %esi,%eax
8010302d:	5b                   	pop    %ebx
8010302e:	5e                   	pop    %esi
8010302f:	5f                   	pop    %edi
80103030:	5d                   	pop    %ebp
80103031:	c3                   	ret    
80103032:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103038:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010303b:	31 f6                	xor    %esi,%esi
}
8010303d:	89 f0                	mov    %esi,%eax
8010303f:	5b                   	pop    %ebx
80103040:	5e                   	pop    %esi
80103041:	5f                   	pop    %edi
80103042:	5d                   	pop    %ebp
80103043:	c3                   	ret    
80103044:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010304a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103050 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103050:	55                   	push   %ebp
80103051:	89 e5                	mov    %esp,%ebp
80103053:	57                   	push   %edi
80103054:	56                   	push   %esi
80103055:	53                   	push   %ebx
80103056:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103059:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103060:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103067:	c1 e0 08             	shl    $0x8,%eax
8010306a:	09 d0                	or     %edx,%eax
8010306c:	c1 e0 04             	shl    $0x4,%eax
8010306f:	85 c0                	test   %eax,%eax
80103071:	75 1b                	jne    8010308e <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103073:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010307a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103081:	c1 e0 08             	shl    $0x8,%eax
80103084:	09 d0                	or     %edx,%eax
80103086:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103089:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010308e:	ba 00 04 00 00       	mov    $0x400,%edx
80103093:	e8 38 ff ff ff       	call   80102fd0 <mpsearch1>
80103098:	85 c0                	test   %eax,%eax
8010309a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010309d:	0f 84 3d 01 00 00    	je     801031e0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801030a3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801030a6:	8b 58 04             	mov    0x4(%eax),%ebx
801030a9:	85 db                	test   %ebx,%ebx
801030ab:	0f 84 4f 01 00 00    	je     80103200 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801030b1:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
801030b7:	83 ec 04             	sub    $0x4,%esp
801030ba:	6a 04                	push   $0x4
801030bc:	68 55 76 10 80       	push   $0x80107655
801030c1:	56                   	push   %esi
801030c2:	e8 99 15 00 00       	call   80104660 <memcmp>
801030c7:	83 c4 10             	add    $0x10,%esp
801030ca:	85 c0                	test   %eax,%eax
801030cc:	0f 85 2e 01 00 00    	jne    80103200 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
801030d2:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801030d9:	3c 01                	cmp    $0x1,%al
801030db:	0f 95 c2             	setne  %dl
801030de:	3c 04                	cmp    $0x4,%al
801030e0:	0f 95 c0             	setne  %al
801030e3:	20 c2                	and    %al,%dl
801030e5:	0f 85 15 01 00 00    	jne    80103200 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
801030eb:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
801030f2:	66 85 ff             	test   %di,%di
801030f5:	74 1a                	je     80103111 <mpinit+0xc1>
801030f7:	89 f0                	mov    %esi,%eax
801030f9:	01 f7                	add    %esi,%edi
  sum = 0;
801030fb:	31 d2                	xor    %edx,%edx
801030fd:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103100:	0f b6 08             	movzbl (%eax),%ecx
80103103:	83 c0 01             	add    $0x1,%eax
80103106:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103108:	39 c7                	cmp    %eax,%edi
8010310a:	75 f4                	jne    80103100 <mpinit+0xb0>
8010310c:	84 d2                	test   %dl,%dl
8010310e:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103111:	85 f6                	test   %esi,%esi
80103113:	0f 84 e7 00 00 00    	je     80103200 <mpinit+0x1b0>
80103119:	84 d2                	test   %dl,%dl
8010311b:	0f 85 df 00 00 00    	jne    80103200 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103121:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103127:	a3 7c 26 11 80       	mov    %eax,0x8011267c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010312c:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103133:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
80103139:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010313e:	01 d6                	add    %edx,%esi
80103140:	39 c6                	cmp    %eax,%esi
80103142:	76 23                	jbe    80103167 <mpinit+0x117>
    switch(*p){
80103144:	0f b6 10             	movzbl (%eax),%edx
80103147:	80 fa 04             	cmp    $0x4,%dl
8010314a:	0f 87 ca 00 00 00    	ja     8010321a <mpinit+0x1ca>
80103150:	ff 24 95 7c 76 10 80 	jmp    *-0x7fef8984(,%edx,4)
80103157:	89 f6                	mov    %esi,%esi
80103159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103160:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103163:	39 c6                	cmp    %eax,%esi
80103165:	77 dd                	ja     80103144 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103167:	85 db                	test   %ebx,%ebx
80103169:	0f 84 9e 00 00 00    	je     8010320d <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010316f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103172:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103176:	74 15                	je     8010318d <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103178:	b8 70 00 00 00       	mov    $0x70,%eax
8010317d:	ba 22 00 00 00       	mov    $0x22,%edx
80103182:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103183:	ba 23 00 00 00       	mov    $0x23,%edx
80103188:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103189:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010318c:	ee                   	out    %al,(%dx)
  }
}
8010318d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103190:	5b                   	pop    %ebx
80103191:	5e                   	pop    %esi
80103192:	5f                   	pop    %edi
80103193:	5d                   	pop    %ebp
80103194:	c3                   	ret    
80103195:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
80103198:	8b 0d 00 2d 11 80    	mov    0x80112d00,%ecx
8010319e:	83 f9 07             	cmp    $0x7,%ecx
801031a1:	7f 19                	jg     801031bc <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031a3:	0f b6 50 01          	movzbl 0x1(%eax),%edx
801031a7:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
801031ad:	83 c1 01             	add    $0x1,%ecx
801031b0:	89 0d 00 2d 11 80    	mov    %ecx,0x80112d00
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031b6:	88 97 80 27 11 80    	mov    %dl,-0x7feed880(%edi)
      p += sizeof(struct mpproc);
801031bc:	83 c0 14             	add    $0x14,%eax
      continue;
801031bf:	e9 7c ff ff ff       	jmp    80103140 <mpinit+0xf0>
801031c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
801031c8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801031cc:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801031cf:	88 15 60 27 11 80    	mov    %dl,0x80112760
      continue;
801031d5:	e9 66 ff ff ff       	jmp    80103140 <mpinit+0xf0>
801031da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
801031e0:	ba 00 00 01 00       	mov    $0x10000,%edx
801031e5:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801031ea:	e8 e1 fd ff ff       	call   80102fd0 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031ef:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
801031f1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031f4:	0f 85 a9 fe ff ff    	jne    801030a3 <mpinit+0x53>
801031fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103200:	83 ec 0c             	sub    $0xc,%esp
80103203:	68 3d 76 10 80       	push   $0x8010763d
80103208:	e8 83 d1 ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
8010320d:	83 ec 0c             	sub    $0xc,%esp
80103210:	68 5c 76 10 80       	push   $0x8010765c
80103215:	e8 76 d1 ff ff       	call   80100390 <panic>
      ismp = 0;
8010321a:	31 db                	xor    %ebx,%ebx
8010321c:	e9 26 ff ff ff       	jmp    80103147 <mpinit+0xf7>
80103221:	66 90                	xchg   %ax,%ax
80103223:	66 90                	xchg   %ax,%ax
80103225:	66 90                	xchg   %ax,%ax
80103227:	66 90                	xchg   %ax,%ax
80103229:	66 90                	xchg   %ax,%ax
8010322b:	66 90                	xchg   %ax,%ax
8010322d:	66 90                	xchg   %ax,%ax
8010322f:	90                   	nop

80103230 <picinit>:
80103230:	55                   	push   %ebp
80103231:	ba 21 00 00 00       	mov    $0x21,%edx
80103236:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010323b:	89 e5                	mov    %esp,%ebp
8010323d:	ee                   	out    %al,(%dx)
8010323e:	ba a1 00 00 00       	mov    $0xa1,%edx
80103243:	ee                   	out    %al,(%dx)
80103244:	5d                   	pop    %ebp
80103245:	c3                   	ret    
80103246:	66 90                	xchg   %ax,%ax
80103248:	66 90                	xchg   %ax,%ax
8010324a:	66 90                	xchg   %ax,%ax
8010324c:	66 90                	xchg   %ax,%ax
8010324e:	66 90                	xchg   %ax,%ax

80103250 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103250:	55                   	push   %ebp
80103251:	89 e5                	mov    %esp,%ebp
80103253:	57                   	push   %edi
80103254:	56                   	push   %esi
80103255:	53                   	push   %ebx
80103256:	83 ec 0c             	sub    $0xc,%esp
80103259:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010325c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010325f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103265:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010326b:	e8 10 db ff ff       	call   80100d80 <filealloc>
80103270:	85 c0                	test   %eax,%eax
80103272:	89 03                	mov    %eax,(%ebx)
80103274:	74 22                	je     80103298 <pipealloc+0x48>
80103276:	e8 05 db ff ff       	call   80100d80 <filealloc>
8010327b:	85 c0                	test   %eax,%eax
8010327d:	89 06                	mov    %eax,(%esi)
8010327f:	74 3f                	je     801032c0 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103281:	e8 4a f2 ff ff       	call   801024d0 <kalloc>
80103286:	85 c0                	test   %eax,%eax
80103288:	89 c7                	mov    %eax,%edi
8010328a:	75 54                	jne    801032e0 <pipealloc+0x90>
  return 0;

 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
8010328c:	8b 03                	mov    (%ebx),%eax
8010328e:	85 c0                	test   %eax,%eax
80103290:	75 34                	jne    801032c6 <pipealloc+0x76>
80103292:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
80103298:	8b 06                	mov    (%esi),%eax
8010329a:	85 c0                	test   %eax,%eax
8010329c:	74 0c                	je     801032aa <pipealloc+0x5a>
    fileclose(*f1);
8010329e:	83 ec 0c             	sub    $0xc,%esp
801032a1:	50                   	push   %eax
801032a2:	e8 99 db ff ff       	call   80100e40 <fileclose>
801032a7:	83 c4 10             	add    $0x10,%esp
  return -1;
}
801032aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801032ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801032b2:	5b                   	pop    %ebx
801032b3:	5e                   	pop    %esi
801032b4:	5f                   	pop    %edi
801032b5:	5d                   	pop    %ebp
801032b6:	c3                   	ret    
801032b7:	89 f6                	mov    %esi,%esi
801032b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
801032c0:	8b 03                	mov    (%ebx),%eax
801032c2:	85 c0                	test   %eax,%eax
801032c4:	74 e4                	je     801032aa <pipealloc+0x5a>
    fileclose(*f0);
801032c6:	83 ec 0c             	sub    $0xc,%esp
801032c9:	50                   	push   %eax
801032ca:	e8 71 db ff ff       	call   80100e40 <fileclose>
  if(*f1)
801032cf:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
801032d1:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801032d4:	85 c0                	test   %eax,%eax
801032d6:	75 c6                	jne    8010329e <pipealloc+0x4e>
801032d8:	eb d0                	jmp    801032aa <pipealloc+0x5a>
801032da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
801032e0:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
801032e3:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801032ea:	00 00 00 
  p->writeopen = 1;
801032ed:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801032f4:	00 00 00 
  p->nwrite = 0;
801032f7:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801032fe:	00 00 00 
  p->nread = 0;
80103301:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103308:	00 00 00 
  initlock(&p->lock, "pipe");
8010330b:	68 90 76 10 80       	push   $0x80107690
80103310:	50                   	push   %eax
80103311:	e8 8a 10 00 00       	call   801043a0 <initlock>
  (*f0)->type = FD_PIPE;
80103316:	8b 03                	mov    (%ebx),%eax
  return 0;
80103318:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
8010331b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103321:	8b 03                	mov    (%ebx),%eax
80103323:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103327:	8b 03                	mov    (%ebx),%eax
80103329:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010332d:	8b 03                	mov    (%ebx),%eax
8010332f:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103332:	8b 06                	mov    (%esi),%eax
80103334:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010333a:	8b 06                	mov    (%esi),%eax
8010333c:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103340:	8b 06                	mov    (%esi),%eax
80103342:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103346:	8b 06                	mov    (%esi),%eax
80103348:	89 78 0c             	mov    %edi,0xc(%eax)
}
8010334b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010334e:	31 c0                	xor    %eax,%eax
}
80103350:	5b                   	pop    %ebx
80103351:	5e                   	pop    %esi
80103352:	5f                   	pop    %edi
80103353:	5d                   	pop    %ebp
80103354:	c3                   	ret    
80103355:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103360 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103360:	55                   	push   %ebp
80103361:	89 e5                	mov    %esp,%ebp
80103363:	56                   	push   %esi
80103364:	53                   	push   %ebx
80103365:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103368:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010336b:	83 ec 0c             	sub    $0xc,%esp
8010336e:	53                   	push   %ebx
8010336f:	e8 1c 11 00 00       	call   80104490 <acquire>
  if(writable){
80103374:	83 c4 10             	add    $0x10,%esp
80103377:	85 f6                	test   %esi,%esi
80103379:	74 45                	je     801033c0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010337b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103381:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103384:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010338b:	00 00 00 
    wakeup(&p->nread);
8010338e:	50                   	push   %eax
8010338f:	e8 dc 0b 00 00       	call   80103f70 <wakeup>
80103394:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103397:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010339d:	85 d2                	test   %edx,%edx
8010339f:	75 0a                	jne    801033ab <pipeclose+0x4b>
801033a1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801033a7:	85 c0                	test   %eax,%eax
801033a9:	74 35                	je     801033e0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801033ab:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801033ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801033b1:	5b                   	pop    %ebx
801033b2:	5e                   	pop    %esi
801033b3:	5d                   	pop    %ebp
    release(&p->lock);
801033b4:	e9 f7 11 00 00       	jmp    801045b0 <release>
801033b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801033c0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801033c6:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
801033c9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801033d0:	00 00 00 
    wakeup(&p->nwrite);
801033d3:	50                   	push   %eax
801033d4:	e8 97 0b 00 00       	call   80103f70 <wakeup>
801033d9:	83 c4 10             	add    $0x10,%esp
801033dc:	eb b9                	jmp    80103397 <pipeclose+0x37>
801033de:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801033e0:	83 ec 0c             	sub    $0xc,%esp
801033e3:	53                   	push   %ebx
801033e4:	e8 c7 11 00 00       	call   801045b0 <release>
    kfree((char*)p);
801033e9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801033ec:	83 c4 10             	add    $0x10,%esp
}
801033ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801033f2:	5b                   	pop    %ebx
801033f3:	5e                   	pop    %esi
801033f4:	5d                   	pop    %ebp
    kfree((char*)p);
801033f5:	e9 26 ef ff ff       	jmp    80102320 <kfree>
801033fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103400 <pipewrite>:

int
pipewrite(struct pipe *p, char *addr, int n)
{
80103400:	55                   	push   %ebp
80103401:	89 e5                	mov    %esp,%ebp
80103403:	57                   	push   %edi
80103404:	56                   	push   %esi
80103405:	53                   	push   %ebx
80103406:	83 ec 28             	sub    $0x28,%esp
80103409:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010340c:	53                   	push   %ebx
8010340d:	e8 7e 10 00 00       	call   80104490 <acquire>
  for(i = 0; i < n; i++){
80103412:	8b 45 10             	mov    0x10(%ebp),%eax
80103415:	83 c4 10             	add    $0x10,%esp
80103418:	85 c0                	test   %eax,%eax
8010341a:	0f 8e c9 00 00 00    	jle    801034e9 <pipewrite+0xe9>
80103420:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103423:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103429:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010342f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103432:	03 4d 10             	add    0x10(%ebp),%ecx
80103435:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103438:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
8010343e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103444:	39 d0                	cmp    %edx,%eax
80103446:	75 71                	jne    801034b9 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
80103448:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010344e:	85 c0                	test   %eax,%eax
80103450:	74 4e                	je     801034a0 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103452:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103458:	eb 3a                	jmp    80103494 <pipewrite+0x94>
8010345a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
80103460:	83 ec 0c             	sub    $0xc,%esp
80103463:	57                   	push   %edi
80103464:	e8 07 0b 00 00       	call   80103f70 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103469:	5a                   	pop    %edx
8010346a:	59                   	pop    %ecx
8010346b:	53                   	push   %ebx
8010346c:	56                   	push   %esi
8010346d:	e8 4e 09 00 00       	call   80103dc0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103472:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103478:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010347e:	83 c4 10             	add    $0x10,%esp
80103481:	05 00 02 00 00       	add    $0x200,%eax
80103486:	39 c2                	cmp    %eax,%edx
80103488:	75 36                	jne    801034c0 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
8010348a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103490:	85 c0                	test   %eax,%eax
80103492:	74 0c                	je     801034a0 <pipewrite+0xa0>
80103494:	e8 67 03 00 00       	call   80103800 <myproc>
80103499:	8b 40 24             	mov    0x24(%eax),%eax
8010349c:	85 c0                	test   %eax,%eax
8010349e:	74 c0                	je     80103460 <pipewrite+0x60>
        release(&p->lock);
801034a0:	83 ec 0c             	sub    $0xc,%esp
801034a3:	53                   	push   %ebx
801034a4:	e8 07 11 00 00       	call   801045b0 <release>
        return -1;
801034a9:	83 c4 10             	add    $0x10,%esp
801034ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801034b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801034b4:	5b                   	pop    %ebx
801034b5:	5e                   	pop    %esi
801034b6:	5f                   	pop    %edi
801034b7:	5d                   	pop    %ebp
801034b8:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801034b9:	89 c2                	mov    %eax,%edx
801034bb:	90                   	nop
801034bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801034c0:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801034c3:	8d 42 01             	lea    0x1(%edx),%eax
801034c6:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801034cc:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801034d2:	83 c6 01             	add    $0x1,%esi
801034d5:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
801034d9:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801034dc:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801034df:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801034e3:	0f 85 4f ff ff ff    	jne    80103438 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801034e9:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801034ef:	83 ec 0c             	sub    $0xc,%esp
801034f2:	50                   	push   %eax
801034f3:	e8 78 0a 00 00       	call   80103f70 <wakeup>
  release(&p->lock);
801034f8:	89 1c 24             	mov    %ebx,(%esp)
801034fb:	e8 b0 10 00 00       	call   801045b0 <release>
  return n;
80103500:	83 c4 10             	add    $0x10,%esp
80103503:	8b 45 10             	mov    0x10(%ebp),%eax
80103506:	eb a9                	jmp    801034b1 <pipewrite+0xb1>
80103508:	90                   	nop
80103509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103510 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103510:	55                   	push   %ebp
80103511:	89 e5                	mov    %esp,%ebp
80103513:	57                   	push   %edi
80103514:	56                   	push   %esi
80103515:	53                   	push   %ebx
80103516:	83 ec 18             	sub    $0x18,%esp
80103519:	8b 75 08             	mov    0x8(%ebp),%esi
8010351c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010351f:	56                   	push   %esi
80103520:	e8 6b 0f 00 00       	call   80104490 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103525:	83 c4 10             	add    $0x10,%esp
80103528:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010352e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103534:	75 6a                	jne    801035a0 <piperead+0x90>
80103536:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010353c:	85 db                	test   %ebx,%ebx
8010353e:	0f 84 c4 00 00 00    	je     80103608 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103544:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
8010354a:	eb 2d                	jmp    80103579 <piperead+0x69>
8010354c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103550:	83 ec 08             	sub    $0x8,%esp
80103553:	56                   	push   %esi
80103554:	53                   	push   %ebx
80103555:	e8 66 08 00 00       	call   80103dc0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010355a:	83 c4 10             	add    $0x10,%esp
8010355d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103563:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103569:	75 35                	jne    801035a0 <piperead+0x90>
8010356b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103571:	85 d2                	test   %edx,%edx
80103573:	0f 84 8f 00 00 00    	je     80103608 <piperead+0xf8>
    if(myproc()->killed){
80103579:	e8 82 02 00 00       	call   80103800 <myproc>
8010357e:	8b 48 24             	mov    0x24(%eax),%ecx
80103581:	85 c9                	test   %ecx,%ecx
80103583:	74 cb                	je     80103550 <piperead+0x40>
      release(&p->lock);
80103585:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103588:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
8010358d:	56                   	push   %esi
8010358e:	e8 1d 10 00 00       	call   801045b0 <release>
      return -1;
80103593:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103596:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103599:	89 d8                	mov    %ebx,%eax
8010359b:	5b                   	pop    %ebx
8010359c:	5e                   	pop    %esi
8010359d:	5f                   	pop    %edi
8010359e:	5d                   	pop    %ebp
8010359f:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035a0:	8b 45 10             	mov    0x10(%ebp),%eax
801035a3:	85 c0                	test   %eax,%eax
801035a5:	7e 61                	jle    80103608 <piperead+0xf8>
    if(p->nread == p->nwrite)
801035a7:	31 db                	xor    %ebx,%ebx
801035a9:	eb 13                	jmp    801035be <piperead+0xae>
801035ab:	90                   	nop
801035ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035b0:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801035b6:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801035bc:	74 1f                	je     801035dd <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
801035be:	8d 41 01             	lea    0x1(%ecx),%eax
801035c1:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801035c7:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
801035cd:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
801035d2:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035d5:	83 c3 01             	add    $0x1,%ebx
801035d8:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801035db:	75 d3                	jne    801035b0 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801035dd:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801035e3:	83 ec 0c             	sub    $0xc,%esp
801035e6:	50                   	push   %eax
801035e7:	e8 84 09 00 00       	call   80103f70 <wakeup>
  release(&p->lock);
801035ec:	89 34 24             	mov    %esi,(%esp)
801035ef:	e8 bc 0f 00 00       	call   801045b0 <release>
  return i;
801035f4:	83 c4 10             	add    $0x10,%esp
}
801035f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035fa:	89 d8                	mov    %ebx,%eax
801035fc:	5b                   	pop    %ebx
801035fd:	5e                   	pop    %esi
801035fe:	5f                   	pop    %edi
801035ff:	5d                   	pop    %ebp
80103600:	c3                   	ret    
80103601:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103608:	31 db                	xor    %ebx,%ebx
8010360a:	eb d1                	jmp    801035dd <piperead+0xcd>
8010360c:	66 90                	xchg   %ax,%ax
8010360e:	66 90                	xchg   %ax,%ax

80103610 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103610:	55                   	push   %ebp
80103611:	89 e5                	mov    %esp,%ebp
80103613:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103614:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
80103619:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010361c:	68 20 2d 11 80       	push   $0x80112d20
80103621:	e8 6a 0e 00 00       	call   80104490 <acquire>
80103626:	83 c4 10             	add    $0x10,%esp
80103629:	eb 14                	jmp    8010363f <allocproc+0x2f>
8010362b:	90                   	nop
8010362c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103630:	83 eb 80             	sub    $0xffffff80,%ebx
80103633:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
80103639:	0f 83 81 00 00 00    	jae    801036c0 <allocproc+0xb0>
    if(p->state == UNUSED)
8010363f:	8b 43 0c             	mov    0xc(%ebx),%eax
80103642:	85 c0                	test   %eax,%eax
80103644:	75 ea                	jne    80103630 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103646:	a1 04 a0 10 80       	mov    0x8010a004,%eax
	p->priority = 10;


  release(&ptable.lock);
8010364b:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
8010364e:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
	p->priority = 10;
80103655:	c7 43 7c 0a 00 00 00 	movl   $0xa,0x7c(%ebx)
  p->pid = nextpid++;
8010365c:	8d 50 01             	lea    0x1(%eax),%edx
8010365f:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
80103662:	68 20 2d 11 80       	push   $0x80112d20
  p->pid = nextpid++;
80103667:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
  release(&ptable.lock);
8010366d:	e8 3e 0f 00 00       	call   801045b0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103672:	e8 59 ee ff ff       	call   801024d0 <kalloc>
80103677:	83 c4 10             	add    $0x10,%esp
8010367a:	85 c0                	test   %eax,%eax
8010367c:	89 43 08             	mov    %eax,0x8(%ebx)
8010367f:	74 58                	je     801036d9 <allocproc+0xc9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103681:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103687:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
8010368a:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
8010368f:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103692:	c7 40 14 d7 58 10 80 	movl   $0x801058d7,0x14(%eax)
  p->context = (struct context*)sp;
80103699:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
8010369c:	6a 14                	push   $0x14
8010369e:	6a 00                	push   $0x0
801036a0:	50                   	push   %eax
801036a1:	e8 6a 0f 00 00       	call   80104610 <memset>
  p->context->eip = (uint)forkret;
801036a6:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
801036a9:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
801036ac:	c7 40 10 f0 36 10 80 	movl   $0x801036f0,0x10(%eax)
}
801036b3:	89 d8                	mov    %ebx,%eax
801036b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801036b8:	c9                   	leave  
801036b9:	c3                   	ret    
801036ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
801036c0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
801036c3:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
801036c5:	68 20 2d 11 80       	push   $0x80112d20
801036ca:	e8 e1 0e 00 00       	call   801045b0 <release>
}
801036cf:	89 d8                	mov    %ebx,%eax
  return 0;
801036d1:	83 c4 10             	add    $0x10,%esp
}
801036d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801036d7:	c9                   	leave  
801036d8:	c3                   	ret    
    p->state = UNUSED;
801036d9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801036e0:	31 db                	xor    %ebx,%ebx
801036e2:	eb cf                	jmp    801036b3 <allocproc+0xa3>
801036e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801036ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801036f0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801036f0:	55                   	push   %ebp
801036f1:	89 e5                	mov    %esp,%ebp
801036f3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801036f6:	68 20 2d 11 80       	push   $0x80112d20
801036fb:	e8 b0 0e 00 00       	call   801045b0 <release>

  if (first) {
80103700:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103705:	83 c4 10             	add    $0x10,%esp
80103708:	85 c0                	test   %eax,%eax
8010370a:	75 04                	jne    80103710 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010370c:	c9                   	leave  
8010370d:	c3                   	ret    
8010370e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103710:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103713:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
8010371a:	00 00 00 
    iinit(ROOTDEV);
8010371d:	6a 01                	push   $0x1
8010371f:	e8 6c dd ff ff       	call   80101490 <iinit>
    initlog(ROOTDEV);
80103724:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010372b:	e8 e0 f3 ff ff       	call   80102b10 <initlog>
80103730:	83 c4 10             	add    $0x10,%esp
}
80103733:	c9                   	leave  
80103734:	c3                   	ret    
80103735:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103740 <pinit>:
{
80103740:	55                   	push   %ebp
80103741:	89 e5                	mov    %esp,%ebp
80103743:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103746:	68 95 76 10 80       	push   $0x80107695
8010374b:	68 20 2d 11 80       	push   $0x80112d20
80103750:	e8 4b 0c 00 00       	call   801043a0 <initlock>
}
80103755:	83 c4 10             	add    $0x10,%esp
80103758:	c9                   	leave  
80103759:	c3                   	ret    
8010375a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103760 <mycpu>:
{
80103760:	55                   	push   %ebp
80103761:	89 e5                	mov    %esp,%ebp
80103763:	56                   	push   %esi
80103764:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103765:	9c                   	pushf  
80103766:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103767:	f6 c4 02             	test   $0x2,%ah
8010376a:	75 5e                	jne    801037ca <mycpu+0x6a>
  apicid = lapicid();
8010376c:	e8 cf ef ff ff       	call   80102740 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103771:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
80103777:	85 f6                	test   %esi,%esi
80103779:	7e 42                	jle    801037bd <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
8010377b:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
80103782:	39 d0                	cmp    %edx,%eax
80103784:	74 30                	je     801037b6 <mycpu+0x56>
80103786:	b9 30 28 11 80       	mov    $0x80112830,%ecx
  for (i = 0; i < ncpu; ++i) {
8010378b:	31 d2                	xor    %edx,%edx
8010378d:	8d 76 00             	lea    0x0(%esi),%esi
80103790:	83 c2 01             	add    $0x1,%edx
80103793:	39 f2                	cmp    %esi,%edx
80103795:	74 26                	je     801037bd <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103797:	0f b6 19             	movzbl (%ecx),%ebx
8010379a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
801037a0:	39 c3                	cmp    %eax,%ebx
801037a2:	75 ec                	jne    80103790 <mycpu+0x30>
801037a4:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
801037aa:	05 80 27 11 80       	add    $0x80112780,%eax
}
801037af:	8d 65 f8             	lea    -0x8(%ebp),%esp
801037b2:	5b                   	pop    %ebx
801037b3:	5e                   	pop    %esi
801037b4:	5d                   	pop    %ebp
801037b5:	c3                   	ret    
    if (cpus[i].apicid == apicid)
801037b6:	b8 80 27 11 80       	mov    $0x80112780,%eax
      return &cpus[i];
801037bb:	eb f2                	jmp    801037af <mycpu+0x4f>
  panic("unknown apicid\n");
801037bd:	83 ec 0c             	sub    $0xc,%esp
801037c0:	68 9c 76 10 80       	push   $0x8010769c
801037c5:	e8 c6 cb ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
801037ca:	83 ec 0c             	sub    $0xc,%esp
801037cd:	68 c8 77 10 80       	push   $0x801077c8
801037d2:	e8 b9 cb ff ff       	call   80100390 <panic>
801037d7:	89 f6                	mov    %esi,%esi
801037d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801037e0 <cpuid>:
cpuid() {
801037e0:	55                   	push   %ebp
801037e1:	89 e5                	mov    %esp,%ebp
801037e3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801037e6:	e8 75 ff ff ff       	call   80103760 <mycpu>
801037eb:	2d 80 27 11 80       	sub    $0x80112780,%eax
}
801037f0:	c9                   	leave  
  return mycpu()-cpus;
801037f1:	c1 f8 04             	sar    $0x4,%eax
801037f4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801037fa:	c3                   	ret    
801037fb:	90                   	nop
801037fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103800 <myproc>:
myproc(void) {
80103800:	55                   	push   %ebp
80103801:	89 e5                	mov    %esp,%ebp
80103803:	53                   	push   %ebx
80103804:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103807:	e8 44 0c 00 00       	call   80104450 <pushcli>
  c = mycpu();
8010380c:	e8 4f ff ff ff       	call   80103760 <mycpu>
  p = c->proc;
80103811:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103817:	e8 34 0d 00 00       	call   80104550 <popcli>
}
8010381c:	83 c4 04             	add    $0x4,%esp
8010381f:	89 d8                	mov    %ebx,%eax
80103821:	5b                   	pop    %ebx
80103822:	5d                   	pop    %ebp
80103823:	c3                   	ret    
80103824:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010382a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103830 <userinit>:
{
80103830:	55                   	push   %ebp
80103831:	89 e5                	mov    %esp,%ebp
80103833:	53                   	push   %ebx
80103834:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103837:	e8 d4 fd ff ff       	call   80103610 <allocproc>
8010383c:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010383e:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
80103843:	e8 68 36 00 00       	call   80106eb0 <setupkvm>
80103848:	85 c0                	test   %eax,%eax
8010384a:	89 43 04             	mov    %eax,0x4(%ebx)
8010384d:	0f 84 bd 00 00 00    	je     80103910 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103853:	83 ec 04             	sub    $0x4,%esp
80103856:	68 2c 00 00 00       	push   $0x2c
8010385b:	68 60 a4 10 80       	push   $0x8010a460
80103860:	50                   	push   %eax
80103861:	e8 2a 33 00 00       	call   80106b90 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103866:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103869:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010386f:	6a 4c                	push   $0x4c
80103871:	6a 00                	push   $0x0
80103873:	ff 73 18             	pushl  0x18(%ebx)
80103876:	e8 95 0d 00 00       	call   80104610 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010387b:	8b 43 18             	mov    0x18(%ebx),%eax
8010387e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103883:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103888:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010388b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010388f:	8b 43 18             	mov    0x18(%ebx),%eax
80103892:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103896:	8b 43 18             	mov    0x18(%ebx),%eax
80103899:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010389d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801038a1:	8b 43 18             	mov    0x18(%ebx),%eax
801038a4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801038a8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801038ac:	8b 43 18             	mov    0x18(%ebx),%eax
801038af:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801038b6:	8b 43 18             	mov    0x18(%ebx),%eax
801038b9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801038c0:	8b 43 18             	mov    0x18(%ebx),%eax
801038c3:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
801038ca:	8d 43 6c             	lea    0x6c(%ebx),%eax
801038cd:	6a 10                	push   $0x10
801038cf:	68 c5 76 10 80       	push   $0x801076c5
801038d4:	50                   	push   %eax
801038d5:	e8 36 0f 00 00       	call   80104810 <safestrcpy>
  p->cwd = namei("/");
801038da:	c7 04 24 ce 76 10 80 	movl   $0x801076ce,(%esp)
801038e1:	e8 0a e6 ff ff       	call   80101ef0 <namei>
801038e6:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
801038e9:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801038f0:	e8 9b 0b 00 00       	call   80104490 <acquire>
  p->state = RUNNABLE;
801038f5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
801038fc:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103903:	e8 a8 0c 00 00       	call   801045b0 <release>
}
80103908:	83 c4 10             	add    $0x10,%esp
8010390b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010390e:	c9                   	leave  
8010390f:	c3                   	ret    
    panic("userinit: out of memory?");
80103910:	83 ec 0c             	sub    $0xc,%esp
80103913:	68 ac 76 10 80       	push   $0x801076ac
80103918:	e8 73 ca ff ff       	call   80100390 <panic>
8010391d:	8d 76 00             	lea    0x0(%esi),%esi

80103920 <growproc>:
{
80103920:	55                   	push   %ebp
80103921:	89 e5                	mov    %esp,%ebp
80103923:	56                   	push   %esi
80103924:	53                   	push   %ebx
80103925:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103928:	e8 23 0b 00 00       	call   80104450 <pushcli>
  c = mycpu();
8010392d:	e8 2e fe ff ff       	call   80103760 <mycpu>
  p = c->proc;
80103932:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103938:	e8 13 0c 00 00       	call   80104550 <popcli>
  if(n > 0){
8010393d:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103940:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103942:	7f 1c                	jg     80103960 <growproc+0x40>
  } else if(n < 0){
80103944:	75 3a                	jne    80103980 <growproc+0x60>
  switchuvm(curproc);
80103946:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103949:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
8010394b:	53                   	push   %ebx
8010394c:	e8 2f 31 00 00       	call   80106a80 <switchuvm>
  return 0;
80103951:	83 c4 10             	add    $0x10,%esp
80103954:	31 c0                	xor    %eax,%eax
}
80103956:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103959:	5b                   	pop    %ebx
8010395a:	5e                   	pop    %esi
8010395b:	5d                   	pop    %ebp
8010395c:	c3                   	ret    
8010395d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103960:	83 ec 04             	sub    $0x4,%esp
80103963:	01 c6                	add    %eax,%esi
80103965:	56                   	push   %esi
80103966:	50                   	push   %eax
80103967:	ff 73 04             	pushl  0x4(%ebx)
8010396a:	e8 61 33 00 00       	call   80106cd0 <allocuvm>
8010396f:	83 c4 10             	add    $0x10,%esp
80103972:	85 c0                	test   %eax,%eax
80103974:	75 d0                	jne    80103946 <growproc+0x26>
      return -1;
80103976:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010397b:	eb d9                	jmp    80103956 <growproc+0x36>
8010397d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103980:	83 ec 04             	sub    $0x4,%esp
80103983:	01 c6                	add    %eax,%esi
80103985:	56                   	push   %esi
80103986:	50                   	push   %eax
80103987:	ff 73 04             	pushl  0x4(%ebx)
8010398a:	e8 71 34 00 00       	call   80106e00 <deallocuvm>
8010398f:	83 c4 10             	add    $0x10,%esp
80103992:	85 c0                	test   %eax,%eax
80103994:	75 b0                	jne    80103946 <growproc+0x26>
80103996:	eb de                	jmp    80103976 <growproc+0x56>
80103998:	90                   	nop
80103999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801039a0 <fork>:
{
801039a0:	55                   	push   %ebp
801039a1:	89 e5                	mov    %esp,%ebp
801039a3:	57                   	push   %edi
801039a4:	56                   	push   %esi
801039a5:	53                   	push   %ebx
801039a6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
801039a9:	e8 a2 0a 00 00       	call   80104450 <pushcli>
  c = mycpu();
801039ae:	e8 ad fd ff ff       	call   80103760 <mycpu>
  p = c->proc;
801039b3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039b9:	e8 92 0b 00 00       	call   80104550 <popcli>
  if((np = allocproc()) == 0){
801039be:	e8 4d fc ff ff       	call   80103610 <allocproc>
801039c3:	85 c0                	test   %eax,%eax
801039c5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801039c8:	0f 84 b7 00 00 00    	je     80103a85 <fork+0xe5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
801039ce:	83 ec 08             	sub    $0x8,%esp
801039d1:	ff 33                	pushl  (%ebx)
801039d3:	ff 73 04             	pushl  0x4(%ebx)
801039d6:	89 c7                	mov    %eax,%edi
801039d8:	e8 a3 35 00 00       	call   80106f80 <copyuvm>
801039dd:	83 c4 10             	add    $0x10,%esp
801039e0:	85 c0                	test   %eax,%eax
801039e2:	89 47 04             	mov    %eax,0x4(%edi)
801039e5:	0f 84 a1 00 00 00    	je     80103a8c <fork+0xec>
  np->sz = curproc->sz;
801039eb:	8b 03                	mov    (%ebx),%eax
801039ed:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801039f0:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
801039f2:	89 59 14             	mov    %ebx,0x14(%ecx)
801039f5:	89 c8                	mov    %ecx,%eax
  *np->tf = *curproc->tf;
801039f7:	8b 79 18             	mov    0x18(%ecx),%edi
801039fa:	8b 73 18             	mov    0x18(%ebx),%esi
801039fd:	b9 13 00 00 00       	mov    $0x13,%ecx
80103a02:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103a04:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103a06:	8b 40 18             	mov    0x18(%eax),%eax
80103a09:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103a10:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103a14:	85 c0                	test   %eax,%eax
80103a16:	74 13                	je     80103a2b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103a18:	83 ec 0c             	sub    $0xc,%esp
80103a1b:	50                   	push   %eax
80103a1c:	e8 cf d3 ff ff       	call   80100df0 <filedup>
80103a21:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103a24:	83 c4 10             	add    $0x10,%esp
80103a27:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103a2b:	83 c6 01             	add    $0x1,%esi
80103a2e:	83 fe 10             	cmp    $0x10,%esi
80103a31:	75 dd                	jne    80103a10 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103a33:	83 ec 0c             	sub    $0xc,%esp
80103a36:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a39:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103a3c:	e8 1f dc ff ff       	call   80101660 <idup>
80103a41:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a44:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103a47:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a4a:	8d 47 6c             	lea    0x6c(%edi),%eax
80103a4d:	6a 10                	push   $0x10
80103a4f:	53                   	push   %ebx
80103a50:	50                   	push   %eax
80103a51:	e8 ba 0d 00 00       	call   80104810 <safestrcpy>
  pid = np->pid;
80103a56:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103a59:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103a60:	e8 2b 0a 00 00       	call   80104490 <acquire>
  np->state = RUNNABLE;
80103a65:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103a6c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103a73:	e8 38 0b 00 00       	call   801045b0 <release>
  return pid;
80103a78:	83 c4 10             	add    $0x10,%esp
}
80103a7b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a7e:	89 d8                	mov    %ebx,%eax
80103a80:	5b                   	pop    %ebx
80103a81:	5e                   	pop    %esi
80103a82:	5f                   	pop    %edi
80103a83:	5d                   	pop    %ebp
80103a84:	c3                   	ret    
    return -1;
80103a85:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103a8a:	eb ef                	jmp    80103a7b <fork+0xdb>
    kfree(np->kstack);
80103a8c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103a8f:	83 ec 0c             	sub    $0xc,%esp
80103a92:	ff 73 08             	pushl  0x8(%ebx)
80103a95:	e8 86 e8 ff ff       	call   80102320 <kfree>
    np->kstack = 0;
80103a9a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103aa1:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103aa8:	83 c4 10             	add    $0x10,%esp
80103aab:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103ab0:	eb c9                	jmp    80103a7b <fork+0xdb>
80103ab2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ac0 <scheduler>:
{
80103ac0:	55                   	push   %ebp
80103ac1:	89 e5                	mov    %esp,%ebp
80103ac3:	57                   	push   %edi
80103ac4:	56                   	push   %esi
80103ac5:	53                   	push   %ebx
80103ac6:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103ac9:	e8 92 fc ff ff       	call   80103760 <mycpu>
80103ace:	8d 70 04             	lea    0x4(%eax),%esi
80103ad1:	89 c3                	mov    %eax,%ebx
  c->proc = 0;
80103ad3:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103ada:	00 00 00 
  asm volatile("sti");
80103add:	fb                   	sti    
    acquire(&ptable.lock);
80103ade:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ae1:	bf 54 2d 11 80       	mov    $0x80112d54,%edi
    acquire(&ptable.lock);
80103ae6:	68 20 2d 11 80       	push   $0x80112d20
80103aeb:	e8 a0 09 00 00       	call   80104490 <acquire>
80103af0:	83 c4 10             	add    $0x10,%esp
80103af3:	eb 0e                	jmp    80103b03 <scheduler+0x43>
80103af5:	8d 76 00             	lea    0x0(%esi),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103af8:	83 ef 80             	sub    $0xffffff80,%edi
80103afb:	81 ff 54 4d 11 80    	cmp    $0x80114d54,%edi
80103b01:	73 64                	jae    80103b67 <scheduler+0xa7>
      if(p->state != RUNNABLE)
80103b03:	83 7f 0c 03          	cmpl   $0x3,0xc(%edi)
80103b07:	75 ef                	jne    80103af8 <scheduler+0x38>
		for(p1 = ptable.proc; p1 < &ptable.proc[NPROC]; p1++){
80103b09:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103b0e:	66 90                	xchg   %ax,%ax
			if(p1->state != RUNNABLE)
80103b10:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80103b14:	75 09                	jne    80103b1f <scheduler+0x5f>
			if ( highP->priority > p1->priority )	// larger value, lower priority
80103b16:	8b 50 7c             	mov    0x7c(%eax),%edx
80103b19:	39 57 7c             	cmp    %edx,0x7c(%edi)
80103b1c:	0f 4f f8             	cmovg  %eax,%edi
		for(p1 = ptable.proc; p1 < &ptable.proc[NPROC]; p1++){
80103b1f:	83 e8 80             	sub    $0xffffff80,%eax
80103b22:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80103b27:	72 e7                	jb     80103b10 <scheduler+0x50>
      switchuvm(p);
80103b29:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103b2c:	89 bb ac 00 00 00    	mov    %edi,0xac(%ebx)
      switchuvm(p);
80103b32:	57                   	push   %edi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b33:	83 ef 80             	sub    $0xffffff80,%edi
      switchuvm(p);
80103b36:	e8 45 2f 00 00       	call   80106a80 <switchuvm>
      p->state = RUNNING;
80103b3b:	c7 47 8c 04 00 00 00 	movl   $0x4,-0x74(%edi)
      swtch(&(c->scheduler), p->context);
80103b42:	58                   	pop    %eax
80103b43:	5a                   	pop    %edx
80103b44:	ff 77 9c             	pushl  -0x64(%edi)
80103b47:	56                   	push   %esi
80103b48:	e8 1e 0d 00 00       	call   8010486b <swtch>
      switchkvm();
80103b4d:	e8 0e 2f 00 00       	call   80106a60 <switchkvm>
      c->proc = 0;
80103b52:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b55:	81 ff 54 4d 11 80    	cmp    $0x80114d54,%edi
      c->proc = 0;
80103b5b:	c7 83 ac 00 00 00 00 	movl   $0x0,0xac(%ebx)
80103b62:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b65:	72 9c                	jb     80103b03 <scheduler+0x43>
    release(&ptable.lock);
80103b67:	83 ec 0c             	sub    $0xc,%esp
80103b6a:	68 20 2d 11 80       	push   $0x80112d20
80103b6f:	e8 3c 0a 00 00       	call   801045b0 <release>
  for(;;){
80103b74:	83 c4 10             	add    $0x10,%esp
80103b77:	e9 61 ff ff ff       	jmp    80103add <scheduler+0x1d>
80103b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103b80 <sched>:
{
80103b80:	55                   	push   %ebp
80103b81:	89 e5                	mov    %esp,%ebp
80103b83:	56                   	push   %esi
80103b84:	53                   	push   %ebx
  pushcli();
80103b85:	e8 c6 08 00 00       	call   80104450 <pushcli>
  c = mycpu();
80103b8a:	e8 d1 fb ff ff       	call   80103760 <mycpu>
  p = c->proc;
80103b8f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b95:	e8 b6 09 00 00       	call   80104550 <popcli>
  if(!holding(&ptable.lock))
80103b9a:	83 ec 0c             	sub    $0xc,%esp
80103b9d:	68 20 2d 11 80       	push   $0x80112d20
80103ba2:	e8 69 08 00 00       	call   80104410 <holding>
80103ba7:	83 c4 10             	add    $0x10,%esp
80103baa:	85 c0                	test   %eax,%eax
80103bac:	74 4f                	je     80103bfd <sched+0x7d>
  if(mycpu()->ncli != 1)
80103bae:	e8 ad fb ff ff       	call   80103760 <mycpu>
80103bb3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103bba:	75 68                	jne    80103c24 <sched+0xa4>
  if(p->state == RUNNING)
80103bbc:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103bc0:	74 55                	je     80103c17 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103bc2:	9c                   	pushf  
80103bc3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103bc4:	f6 c4 02             	test   $0x2,%ah
80103bc7:	75 41                	jne    80103c0a <sched+0x8a>
  intena = mycpu()->intena;
80103bc9:	e8 92 fb ff ff       	call   80103760 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103bce:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103bd1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103bd7:	e8 84 fb ff ff       	call   80103760 <mycpu>
80103bdc:	83 ec 08             	sub    $0x8,%esp
80103bdf:	ff 70 04             	pushl  0x4(%eax)
80103be2:	53                   	push   %ebx
80103be3:	e8 83 0c 00 00       	call   8010486b <swtch>
  mycpu()->intena = intena;
80103be8:	e8 73 fb ff ff       	call   80103760 <mycpu>
}
80103bed:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103bf0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103bf6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103bf9:	5b                   	pop    %ebx
80103bfa:	5e                   	pop    %esi
80103bfb:	5d                   	pop    %ebp
80103bfc:	c3                   	ret    
    panic("sched ptable.lock");
80103bfd:	83 ec 0c             	sub    $0xc,%esp
80103c00:	68 d0 76 10 80       	push   $0x801076d0
80103c05:	e8 86 c7 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103c0a:	83 ec 0c             	sub    $0xc,%esp
80103c0d:	68 fc 76 10 80       	push   $0x801076fc
80103c12:	e8 79 c7 ff ff       	call   80100390 <panic>
    panic("sched running");
80103c17:	83 ec 0c             	sub    $0xc,%esp
80103c1a:	68 ee 76 10 80       	push   $0x801076ee
80103c1f:	e8 6c c7 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103c24:	83 ec 0c             	sub    $0xc,%esp
80103c27:	68 e2 76 10 80       	push   $0x801076e2
80103c2c:	e8 5f c7 ff ff       	call   80100390 <panic>
80103c31:	eb 0d                	jmp    80103c40 <exit>
80103c33:	90                   	nop
80103c34:	90                   	nop
80103c35:	90                   	nop
80103c36:	90                   	nop
80103c37:	90                   	nop
80103c38:	90                   	nop
80103c39:	90                   	nop
80103c3a:	90                   	nop
80103c3b:	90                   	nop
80103c3c:	90                   	nop
80103c3d:	90                   	nop
80103c3e:	90                   	nop
80103c3f:	90                   	nop

80103c40 <exit>:
{
80103c40:	55                   	push   %ebp
80103c41:	89 e5                	mov    %esp,%ebp
80103c43:	57                   	push   %edi
80103c44:	56                   	push   %esi
80103c45:	53                   	push   %ebx
80103c46:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80103c49:	e8 02 08 00 00       	call   80104450 <pushcli>
  c = mycpu();
80103c4e:	e8 0d fb ff ff       	call   80103760 <mycpu>
  p = c->proc;
80103c53:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103c59:	e8 f2 08 00 00       	call   80104550 <popcli>
  if(curproc == initproc)
80103c5e:	39 35 b8 a5 10 80    	cmp    %esi,0x8010a5b8
80103c64:	8d 5e 28             	lea    0x28(%esi),%ebx
80103c67:	8d 7e 68             	lea    0x68(%esi),%edi
80103c6a:	0f 84 e7 00 00 00    	je     80103d57 <exit+0x117>
    if(curproc->ofile[fd]){
80103c70:	8b 03                	mov    (%ebx),%eax
80103c72:	85 c0                	test   %eax,%eax
80103c74:	74 12                	je     80103c88 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103c76:	83 ec 0c             	sub    $0xc,%esp
80103c79:	50                   	push   %eax
80103c7a:	e8 c1 d1 ff ff       	call   80100e40 <fileclose>
      curproc->ofile[fd] = 0;
80103c7f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103c85:	83 c4 10             	add    $0x10,%esp
80103c88:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80103c8b:	39 fb                	cmp    %edi,%ebx
80103c8d:	75 e1                	jne    80103c70 <exit+0x30>
  begin_op();
80103c8f:	e8 1c ef ff ff       	call   80102bb0 <begin_op>
  iput(curproc->cwd);
80103c94:	83 ec 0c             	sub    $0xc,%esp
80103c97:	ff 76 68             	pushl  0x68(%esi)
80103c9a:	e8 21 db ff ff       	call   801017c0 <iput>
  end_op();
80103c9f:	e8 7c ef ff ff       	call   80102c20 <end_op>
  curproc->cwd = 0;
80103ca4:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
80103cab:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103cb2:	e8 d9 07 00 00       	call   80104490 <acquire>
  wakeup1(curproc->parent);
80103cb7:	8b 56 14             	mov    0x14(%esi),%edx
80103cba:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103cbd:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103cc2:	eb 0e                	jmp    80103cd2 <exit+0x92>
80103cc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103cc8:	83 e8 80             	sub    $0xffffff80,%eax
80103ccb:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80103cd0:	73 1c                	jae    80103cee <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
80103cd2:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103cd6:	75 f0                	jne    80103cc8 <exit+0x88>
80103cd8:	3b 50 20             	cmp    0x20(%eax),%edx
80103cdb:	75 eb                	jne    80103cc8 <exit+0x88>
      p->state = RUNNABLE;
80103cdd:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ce4:	83 e8 80             	sub    $0xffffff80,%eax
80103ce7:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80103cec:	72 e4                	jb     80103cd2 <exit+0x92>
      p->parent = initproc;
80103cee:	8b 0d b8 a5 10 80    	mov    0x8010a5b8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103cf4:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103cf9:	eb 10                	jmp    80103d0b <exit+0xcb>
80103cfb:	90                   	nop
80103cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d00:	83 ea 80             	sub    $0xffffff80,%edx
80103d03:	81 fa 54 4d 11 80    	cmp    $0x80114d54,%edx
80103d09:	73 33                	jae    80103d3e <exit+0xfe>
    if(p->parent == curproc){
80103d0b:	39 72 14             	cmp    %esi,0x14(%edx)
80103d0e:	75 f0                	jne    80103d00 <exit+0xc0>
      if(p->state == ZOMBIE)
80103d10:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103d14:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103d17:	75 e7                	jne    80103d00 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d19:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103d1e:	eb 0a                	jmp    80103d2a <exit+0xea>
80103d20:	83 e8 80             	sub    $0xffffff80,%eax
80103d23:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80103d28:	73 d6                	jae    80103d00 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103d2a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103d2e:	75 f0                	jne    80103d20 <exit+0xe0>
80103d30:	3b 48 20             	cmp    0x20(%eax),%ecx
80103d33:	75 eb                	jne    80103d20 <exit+0xe0>
      p->state = RUNNABLE;
80103d35:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103d3c:	eb e2                	jmp    80103d20 <exit+0xe0>
  curproc->state = ZOMBIE;
80103d3e:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103d45:	e8 36 fe ff ff       	call   80103b80 <sched>
  panic("zombie exit");
80103d4a:	83 ec 0c             	sub    $0xc,%esp
80103d4d:	68 1d 77 10 80       	push   $0x8010771d
80103d52:	e8 39 c6 ff ff       	call   80100390 <panic>
    panic("init exiting");
80103d57:	83 ec 0c             	sub    $0xc,%esp
80103d5a:	68 10 77 10 80       	push   $0x80107710
80103d5f:	e8 2c c6 ff ff       	call   80100390 <panic>
80103d64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103d6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103d70 <yield>:
{
80103d70:	55                   	push   %ebp
80103d71:	89 e5                	mov    %esp,%ebp
80103d73:	53                   	push   %ebx
80103d74:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103d77:	68 20 2d 11 80       	push   $0x80112d20
80103d7c:	e8 0f 07 00 00       	call   80104490 <acquire>
  pushcli();
80103d81:	e8 ca 06 00 00       	call   80104450 <pushcli>
  c = mycpu();
80103d86:	e8 d5 f9 ff ff       	call   80103760 <mycpu>
  p = c->proc;
80103d8b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d91:	e8 ba 07 00 00       	call   80104550 <popcli>
  myproc()->state = RUNNABLE;
80103d96:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103d9d:	e8 de fd ff ff       	call   80103b80 <sched>
  release(&ptable.lock);
80103da2:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103da9:	e8 02 08 00 00       	call   801045b0 <release>
}
80103dae:	83 c4 10             	add    $0x10,%esp
80103db1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103db4:	c9                   	leave  
80103db5:	c3                   	ret    
80103db6:	8d 76 00             	lea    0x0(%esi),%esi
80103db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103dc0 <sleep>:
{
80103dc0:	55                   	push   %ebp
80103dc1:	89 e5                	mov    %esp,%ebp
80103dc3:	57                   	push   %edi
80103dc4:	56                   	push   %esi
80103dc5:	53                   	push   %ebx
80103dc6:	83 ec 0c             	sub    $0xc,%esp
80103dc9:	8b 7d 08             	mov    0x8(%ebp),%edi
80103dcc:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103dcf:	e8 7c 06 00 00       	call   80104450 <pushcli>
  c = mycpu();
80103dd4:	e8 87 f9 ff ff       	call   80103760 <mycpu>
  p = c->proc;
80103dd9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ddf:	e8 6c 07 00 00       	call   80104550 <popcli>
  if(p == 0)
80103de4:	85 db                	test   %ebx,%ebx
80103de6:	0f 84 87 00 00 00    	je     80103e73 <sleep+0xb3>
  if(lk == 0)
80103dec:	85 f6                	test   %esi,%esi
80103dee:	74 76                	je     80103e66 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103df0:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
80103df6:	74 50                	je     80103e48 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103df8:	83 ec 0c             	sub    $0xc,%esp
80103dfb:	68 20 2d 11 80       	push   $0x80112d20
80103e00:	e8 8b 06 00 00       	call   80104490 <acquire>
    release(lk);
80103e05:	89 34 24             	mov    %esi,(%esp)
80103e08:	e8 a3 07 00 00       	call   801045b0 <release>
  p->chan = chan;
80103e0d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103e10:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103e17:	e8 64 fd ff ff       	call   80103b80 <sched>
  p->chan = 0;
80103e1c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103e23:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103e2a:	e8 81 07 00 00       	call   801045b0 <release>
    acquire(lk);
80103e2f:	89 75 08             	mov    %esi,0x8(%ebp)
80103e32:	83 c4 10             	add    $0x10,%esp
}
80103e35:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103e38:	5b                   	pop    %ebx
80103e39:	5e                   	pop    %esi
80103e3a:	5f                   	pop    %edi
80103e3b:	5d                   	pop    %ebp
    acquire(lk);
80103e3c:	e9 4f 06 00 00       	jmp    80104490 <acquire>
80103e41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80103e48:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103e4b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103e52:	e8 29 fd ff ff       	call   80103b80 <sched>
  p->chan = 0;
80103e57:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103e5e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103e61:	5b                   	pop    %ebx
80103e62:	5e                   	pop    %esi
80103e63:	5f                   	pop    %edi
80103e64:	5d                   	pop    %ebp
80103e65:	c3                   	ret    
    panic("sleep without lk");
80103e66:	83 ec 0c             	sub    $0xc,%esp
80103e69:	68 2f 77 10 80       	push   $0x8010772f
80103e6e:	e8 1d c5 ff ff       	call   80100390 <panic>
    panic("sleep");
80103e73:	83 ec 0c             	sub    $0xc,%esp
80103e76:	68 29 77 10 80       	push   $0x80107729
80103e7b:	e8 10 c5 ff ff       	call   80100390 <panic>

80103e80 <wait>:
{
80103e80:	55                   	push   %ebp
80103e81:	89 e5                	mov    %esp,%ebp
80103e83:	56                   	push   %esi
80103e84:	53                   	push   %ebx
  pushcli();
80103e85:	e8 c6 05 00 00       	call   80104450 <pushcli>
  c = mycpu();
80103e8a:	e8 d1 f8 ff ff       	call   80103760 <mycpu>
  p = c->proc;
80103e8f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103e95:	e8 b6 06 00 00       	call   80104550 <popcli>
  acquire(&ptable.lock);
80103e9a:	83 ec 0c             	sub    $0xc,%esp
80103e9d:	68 20 2d 11 80       	push   $0x80112d20
80103ea2:	e8 e9 05 00 00       	call   80104490 <acquire>
80103ea7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103eaa:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103eac:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103eb1:	eb 10                	jmp    80103ec3 <wait+0x43>
80103eb3:	90                   	nop
80103eb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103eb8:	83 eb 80             	sub    $0xffffff80,%ebx
80103ebb:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
80103ec1:	73 1b                	jae    80103ede <wait+0x5e>
      if(p->parent != curproc)
80103ec3:	39 73 14             	cmp    %esi,0x14(%ebx)
80103ec6:	75 f0                	jne    80103eb8 <wait+0x38>
      if(p->state == ZOMBIE){
80103ec8:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103ecc:	74 32                	je     80103f00 <wait+0x80>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ece:	83 eb 80             	sub    $0xffffff80,%ebx
      havekids = 1;
80103ed1:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ed6:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
80103edc:	72 e5                	jb     80103ec3 <wait+0x43>
    if(!havekids || curproc->killed){
80103ede:	85 c0                	test   %eax,%eax
80103ee0:	74 74                	je     80103f56 <wait+0xd6>
80103ee2:	8b 46 24             	mov    0x24(%esi),%eax
80103ee5:	85 c0                	test   %eax,%eax
80103ee7:	75 6d                	jne    80103f56 <wait+0xd6>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103ee9:	83 ec 08             	sub    $0x8,%esp
80103eec:	68 20 2d 11 80       	push   $0x80112d20
80103ef1:	56                   	push   %esi
80103ef2:	e8 c9 fe ff ff       	call   80103dc0 <sleep>
    havekids = 0;
80103ef7:	83 c4 10             	add    $0x10,%esp
80103efa:	eb ae                	jmp    80103eaa <wait+0x2a>
80103efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
80103f00:	83 ec 0c             	sub    $0xc,%esp
80103f03:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80103f06:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103f09:	e8 12 e4 ff ff       	call   80102320 <kfree>
        freevm(p->pgdir);
80103f0e:	5a                   	pop    %edx
80103f0f:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80103f12:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103f19:	e8 12 2f 00 00       	call   80106e30 <freevm>
        release(&ptable.lock);
80103f1e:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
        p->pid = 0;
80103f25:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103f2c:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103f33:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103f37:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103f3e:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103f45:	e8 66 06 00 00       	call   801045b0 <release>
        return pid;
80103f4a:	83 c4 10             	add    $0x10,%esp
}
80103f4d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103f50:	89 f0                	mov    %esi,%eax
80103f52:	5b                   	pop    %ebx
80103f53:	5e                   	pop    %esi
80103f54:	5d                   	pop    %ebp
80103f55:	c3                   	ret    
      release(&ptable.lock);
80103f56:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103f59:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80103f5e:	68 20 2d 11 80       	push   $0x80112d20
80103f63:	e8 48 06 00 00       	call   801045b0 <release>
      return -1;
80103f68:	83 c4 10             	add    $0x10,%esp
80103f6b:	eb e0                	jmp    80103f4d <wait+0xcd>
80103f6d:	8d 76 00             	lea    0x0(%esi),%esi

80103f70 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80103f70:	55                   	push   %ebp
80103f71:	89 e5                	mov    %esp,%ebp
80103f73:	53                   	push   %ebx
80103f74:	83 ec 10             	sub    $0x10,%esp
80103f77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103f7a:	68 20 2d 11 80       	push   $0x80112d20
80103f7f:	e8 0c 05 00 00       	call   80104490 <acquire>
80103f84:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f87:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103f8c:	eb 0c                	jmp    80103f9a <wakeup+0x2a>
80103f8e:	66 90                	xchg   %ax,%ax
80103f90:	83 e8 80             	sub    $0xffffff80,%eax
80103f93:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80103f98:	73 1c                	jae    80103fb6 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
80103f9a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f9e:	75 f0                	jne    80103f90 <wakeup+0x20>
80103fa0:	3b 58 20             	cmp    0x20(%eax),%ebx
80103fa3:	75 eb                	jne    80103f90 <wakeup+0x20>
      p->state = RUNNABLE;
80103fa5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103fac:	83 e8 80             	sub    $0xffffff80,%eax
80103faf:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80103fb4:	72 e4                	jb     80103f9a <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80103fb6:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
80103fbd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103fc0:	c9                   	leave  
  release(&ptable.lock);
80103fc1:	e9 ea 05 00 00       	jmp    801045b0 <release>
80103fc6:	8d 76 00             	lea    0x0(%esi),%esi
80103fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103fd0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80103fd0:	55                   	push   %ebp
80103fd1:	89 e5                	mov    %esp,%ebp
80103fd3:	53                   	push   %ebx
80103fd4:	83 ec 10             	sub    $0x10,%esp
80103fd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80103fda:	68 20 2d 11 80       	push   $0x80112d20
80103fdf:	e8 ac 04 00 00       	call   80104490 <acquire>
80103fe4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fe7:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103fec:	eb 0c                	jmp    80103ffa <kill+0x2a>
80103fee:	66 90                	xchg   %ax,%ax
80103ff0:	83 e8 80             	sub    $0xffffff80,%eax
80103ff3:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80103ff8:	73 36                	jae    80104030 <kill+0x60>
    if(p->pid == pid){
80103ffa:	39 58 10             	cmp    %ebx,0x10(%eax)
80103ffd:	75 f1                	jne    80103ff0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80103fff:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104003:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010400a:	75 07                	jne    80104013 <kill+0x43>
        p->state = RUNNABLE;
8010400c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104013:	83 ec 0c             	sub    $0xc,%esp
80104016:	68 20 2d 11 80       	push   $0x80112d20
8010401b:	e8 90 05 00 00       	call   801045b0 <release>
      return 0;
80104020:	83 c4 10             	add    $0x10,%esp
80104023:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104025:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104028:	c9                   	leave  
80104029:	c3                   	ret    
8010402a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104030:	83 ec 0c             	sub    $0xc,%esp
80104033:	68 20 2d 11 80       	push   $0x80112d20
80104038:	e8 73 05 00 00       	call   801045b0 <release>
  return -1;
8010403d:	83 c4 10             	add    $0x10,%esp
80104040:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104045:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104048:	c9                   	leave  
80104049:	c3                   	ret    
8010404a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104050 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104050:	55                   	push   %ebp
80104051:	89 e5                	mov    %esp,%ebp
80104053:	57                   	push   %edi
80104054:	56                   	push   %esi
80104055:	53                   	push   %ebx
80104056:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104059:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
8010405e:	83 ec 3c             	sub    $0x3c,%esp
80104061:	eb 24                	jmp    80104087 <procdump+0x37>
80104063:	90                   	nop
80104064:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104068:	83 ec 0c             	sub    $0xc,%esp
8010406b:	68 43 7b 10 80       	push   $0x80107b43
80104070:	e8 eb c5 ff ff       	call   80100660 <cprintf>
80104075:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104078:	83 eb 80             	sub    $0xffffff80,%ebx
8010407b:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
80104081:	0f 83 81 00 00 00    	jae    80104108 <procdump+0xb8>
    if(p->state == UNUSED)
80104087:	8b 43 0c             	mov    0xc(%ebx),%eax
8010408a:	85 c0                	test   %eax,%eax
8010408c:	74 ea                	je     80104078 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010408e:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104091:	ba 40 77 10 80       	mov    $0x80107740,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104096:	77 11                	ja     801040a9 <procdump+0x59>
80104098:	8b 14 85 14 78 10 80 	mov    -0x7fef87ec(,%eax,4),%edx
      state = "???";
8010409f:	b8 40 77 10 80       	mov    $0x80107740,%eax
801040a4:	85 d2                	test   %edx,%edx
801040a6:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801040a9:	8d 43 6c             	lea    0x6c(%ebx),%eax
801040ac:	50                   	push   %eax
801040ad:	52                   	push   %edx
801040ae:	ff 73 10             	pushl  0x10(%ebx)
801040b1:	68 44 77 10 80       	push   $0x80107744
801040b6:	e8 a5 c5 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
801040bb:	83 c4 10             	add    $0x10,%esp
801040be:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
801040c2:	75 a4                	jne    80104068 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801040c4:	8d 45 c0             	lea    -0x40(%ebp),%eax
801040c7:	83 ec 08             	sub    $0x8,%esp
801040ca:	8d 7d c0             	lea    -0x40(%ebp),%edi
801040cd:	50                   	push   %eax
801040ce:	8b 43 1c             	mov    0x1c(%ebx),%eax
801040d1:	8b 40 0c             	mov    0xc(%eax),%eax
801040d4:	83 c0 08             	add    $0x8,%eax
801040d7:	50                   	push   %eax
801040d8:	e8 e3 02 00 00       	call   801043c0 <getcallerpcs>
801040dd:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
801040e0:	8b 17                	mov    (%edi),%edx
801040e2:	85 d2                	test   %edx,%edx
801040e4:	74 82                	je     80104068 <procdump+0x18>
        cprintf(" %p", pc[i]);
801040e6:	83 ec 08             	sub    $0x8,%esp
801040e9:	83 c7 04             	add    $0x4,%edi
801040ec:	52                   	push   %edx
801040ed:	68 81 71 10 80       	push   $0x80107181
801040f2:	e8 69 c5 ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801040f7:	83 c4 10             	add    $0x10,%esp
801040fa:	39 fe                	cmp    %edi,%esi
801040fc:	75 e2                	jne    801040e0 <procdump+0x90>
801040fe:	e9 65 ff ff ff       	jmp    80104068 <procdump+0x18>
80104103:	90                   	nop
80104104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
}
80104108:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010410b:	5b                   	pop    %ebx
8010410c:	5e                   	pop    %esi
8010410d:	5f                   	pop    %edi
8010410e:	5d                   	pop    %ebp
8010410f:	c3                   	ret    

80104110 <cps>:



//current process status
int cps() {
80104110:	55                   	push   %ebp
80104111:	89 e5                	mov    %esp,%ebp
80104113:	53                   	push   %ebx
80104114:	83 ec 10             	sub    $0x10,%esp
  asm volatile("sti");
80104117:	fb                   	sti    
	struct proc *p;
	// Enable interrupts on this processor.
	sti();
	// Loop over process table looking for process with pid.
	acquire(&ptable.lock);
80104118:	68 20 2d 11 80       	push   $0x80112d20
	cprintf("name \t pid \t state \t \t priority \n");
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010411d:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
	acquire(&ptable.lock);
80104122:	e8 69 03 00 00       	call   80104490 <acquire>
	cprintf("name \t pid \t state \t \t priority \n");
80104127:	c7 04 24 f0 77 10 80 	movl   $0x801077f0,(%esp)
8010412e:	e8 2d c5 ff ff       	call   80100660 <cprintf>
80104133:	83 c4 10             	add    $0x10,%esp
80104136:	eb 1d                	jmp    80104155 <cps+0x45>
80104138:	90                   	nop
80104139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		if ( p->state == SLEEPING )
			cprintf("%s \t %d \t SLEEPING \t %d \n ", p->name, p->pid,p->priority);
		else if ( p->state == RUNNING )
80104140:	83 f8 04             	cmp    $0x4,%eax
80104143:	74 5b                	je     801041a0 <cps+0x90>
			cprintf("%s \t %d \t RUNNING \t %d \n ", p->name, p->pid,p->priority);
		else if ( p->state == RUNNABLE )
80104145:	83 f8 03             	cmp    $0x3,%eax
80104148:	74 76                	je     801041c0 <cps+0xb0>
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010414a:	83 eb 80             	sub    $0xffffff80,%ebx
8010414d:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
80104153:	73 2a                	jae    8010417f <cps+0x6f>
		if ( p->state == SLEEPING )
80104155:	8b 43 0c             	mov    0xc(%ebx),%eax
80104158:	83 f8 02             	cmp    $0x2,%eax
8010415b:	75 e3                	jne    80104140 <cps+0x30>
			cprintf("%s \t %d \t SLEEPING \t %d \n ", p->name, p->pid,p->priority);
8010415d:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104160:	ff 73 7c             	pushl  0x7c(%ebx)
80104163:	ff 73 10             	pushl  0x10(%ebx)
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104166:	83 eb 80             	sub    $0xffffff80,%ebx
			cprintf("%s \t %d \t SLEEPING \t %d \n ", p->name, p->pid,p->priority);
80104169:	50                   	push   %eax
8010416a:	68 4d 77 10 80       	push   $0x8010774d
8010416f:	e8 ec c4 ff ff       	call   80100660 <cprintf>
80104174:	83 c4 10             	add    $0x10,%esp
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104177:	81 fb 54 4d 11 80    	cmp    $0x80114d54,%ebx
8010417d:	72 d6                	jb     80104155 <cps+0x45>
			cprintf("%s \t %d \t RUNNABLE \t %d \n ", p->name, p->pid,p->priority);
	}
	release(&ptable.lock);
8010417f:	83 ec 0c             	sub    $0xc,%esp
80104182:	68 20 2d 11 80       	push   $0x80112d20
80104187:	e8 24 04 00 00       	call   801045b0 <release>
	return 22;
}
8010418c:	b8 16 00 00 00       	mov    $0x16,%eax
80104191:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104194:	c9                   	leave  
80104195:	c3                   	ret    
80104196:	8d 76 00             	lea    0x0(%esi),%esi
80104199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
			cprintf("%s \t %d \t RUNNING \t %d \n ", p->name, p->pid,p->priority);
801041a0:	8d 43 6c             	lea    0x6c(%ebx),%eax
801041a3:	ff 73 7c             	pushl  0x7c(%ebx)
801041a6:	ff 73 10             	pushl  0x10(%ebx)
801041a9:	50                   	push   %eax
801041aa:	68 68 77 10 80       	push   $0x80107768
801041af:	e8 ac c4 ff ff       	call   80100660 <cprintf>
801041b4:	83 c4 10             	add    $0x10,%esp
801041b7:	eb 91                	jmp    8010414a <cps+0x3a>
801041b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			cprintf("%s \t %d \t RUNNABLE \t %d \n ", p->name, p->pid,p->priority);
801041c0:	8d 43 6c             	lea    0x6c(%ebx),%eax
801041c3:	ff 73 7c             	pushl  0x7c(%ebx)
801041c6:	ff 73 10             	pushl  0x10(%ebx)
801041c9:	50                   	push   %eax
801041ca:	68 82 77 10 80       	push   $0x80107782
801041cf:	e8 8c c4 ff ff       	call   80100660 <cprintf>
801041d4:	83 c4 10             	add    $0x10,%esp
801041d7:	e9 6e ff ff ff       	jmp    8010414a <cps+0x3a>
801041dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801041e0 <chpr>:


//change priority
int
chpr( int pid, int priority )
{
801041e0:	55                   	push   %ebp
801041e1:	89 e5                	mov    %esp,%ebp
801041e3:	53                   	push   %ebx
801041e4:	83 ec 10             	sub    $0x10,%esp
801041e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
	struct proc *p;
	acquire(&ptable.lock);
801041ea:	68 20 2d 11 80       	push   $0x80112d20
801041ef:	e8 9c 02 00 00       	call   80104490 <acquire>
801041f4:	83 c4 10             	add    $0x10,%esp
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041f7:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
801041fc:	eb 0d                	jmp    8010420b <chpr+0x2b>
801041fe:	66 90                	xchg   %ax,%ax
80104200:	83 ea 80             	sub    $0xffffff80,%edx
80104203:	81 fa 54 4d 11 80    	cmp    $0x80114d54,%edx
80104209:	73 0b                	jae    80104216 <chpr+0x36>
		if(p->pid == pid ) {
8010420b:	39 5a 10             	cmp    %ebx,0x10(%edx)
8010420e:	75 f0                	jne    80104200 <chpr+0x20>
			p->priority = priority;
80104210:	8b 45 0c             	mov    0xc(%ebp),%eax
80104213:	89 42 7c             	mov    %eax,0x7c(%edx)
			break;
		}
	}
	release(&ptable.lock);
80104216:	83 ec 0c             	sub    $0xc,%esp
80104219:	68 20 2d 11 80       	push   $0x80112d20
8010421e:	e8 8d 03 00 00       	call   801045b0 <release>
	return pid;
}
80104223:	89 d8                	mov    %ebx,%eax
80104225:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104228:	c9                   	leave  
80104229:	c3                   	ret    
8010422a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104230 <getprocinfo>:


//
int
getprocinfo(int pid, struct processInfo *procInfo)
{
80104230:	55                   	push   %ebp
80104231:	89 e5                	mov    %esp,%ebp
80104233:	56                   	push   %esi
80104234:	53                   	push   %ebx
80104235:	8b 75 0c             	mov    0xc(%ebp),%esi
80104238:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010423b:	fb                   	sti    
    struct proc *p;
    sti();
    acquire(&ptable.lock);
8010423c:	83 ec 0c             	sub    $0xc,%esp
8010423f:	68 20 2d 11 80       	push   $0x80112d20
80104244:	e8 47 02 00 00       	call   80104490 <acquire>
80104249:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010424c:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80104251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if(p->pid == pid){
80104258:	39 58 10             	cmp    %ebx,0x10(%eax)
8010425b:	75 02                	jne    8010425f <getprocinfo+0x2f>
            procInfo->pid  = pid;
8010425d:	89 1e                	mov    %ebx,(%esi)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010425f:	83 e8 80             	sub    $0xffffff80,%eax
80104262:	3d 54 4d 11 80       	cmp    $0x80114d54,%eax
80104267:	72 ef                	jb     80104258 <getprocinfo+0x28>
        }
    }
    release(&ptable.lock);
80104269:	83 ec 0c             	sub    $0xc,%esp
8010426c:	68 20 2d 11 80       	push   $0x80112d20
80104271:	e8 3a 03 00 00       	call   801045b0 <release>
    return 24;
}
80104276:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104279:	b8 18 00 00 00       	mov    $0x18,%eax
8010427e:	5b                   	pop    %ebx
8010427f:	5e                   	pop    %esi
80104280:	5d                   	pop    %ebp
80104281:	c3                   	ret    
80104282:	66 90                	xchg   %ax,%ax
80104284:	66 90                	xchg   %ax,%ax
80104286:	66 90                	xchg   %ax,%ax
80104288:	66 90                	xchg   %ax,%ax
8010428a:	66 90                	xchg   %ax,%ax
8010428c:	66 90                	xchg   %ax,%ax
8010428e:	66 90                	xchg   %ax,%ax

80104290 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104290:	55                   	push   %ebp
80104291:	89 e5                	mov    %esp,%ebp
80104293:	53                   	push   %ebx
80104294:	83 ec 0c             	sub    $0xc,%esp
80104297:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010429a:	68 2c 78 10 80       	push   $0x8010782c
8010429f:	8d 43 04             	lea    0x4(%ebx),%eax
801042a2:	50                   	push   %eax
801042a3:	e8 f8 00 00 00       	call   801043a0 <initlock>
  lk->name = name;
801042a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801042ab:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801042b1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801042b4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801042bb:	89 43 38             	mov    %eax,0x38(%ebx)
}
801042be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042c1:	c9                   	leave  
801042c2:	c3                   	ret    
801042c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801042c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801042d0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801042d0:	55                   	push   %ebp
801042d1:	89 e5                	mov    %esp,%ebp
801042d3:	56                   	push   %esi
801042d4:	53                   	push   %ebx
801042d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801042d8:	83 ec 0c             	sub    $0xc,%esp
801042db:	8d 73 04             	lea    0x4(%ebx),%esi
801042de:	56                   	push   %esi
801042df:	e8 ac 01 00 00       	call   80104490 <acquire>
  while (lk->locked) {
801042e4:	8b 13                	mov    (%ebx),%edx
801042e6:	83 c4 10             	add    $0x10,%esp
801042e9:	85 d2                	test   %edx,%edx
801042eb:	74 16                	je     80104303 <acquiresleep+0x33>
801042ed:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801042f0:	83 ec 08             	sub    $0x8,%esp
801042f3:	56                   	push   %esi
801042f4:	53                   	push   %ebx
801042f5:	e8 c6 fa ff ff       	call   80103dc0 <sleep>
  while (lk->locked) {
801042fa:	8b 03                	mov    (%ebx),%eax
801042fc:	83 c4 10             	add    $0x10,%esp
801042ff:	85 c0                	test   %eax,%eax
80104301:	75 ed                	jne    801042f0 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104303:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104309:	e8 f2 f4 ff ff       	call   80103800 <myproc>
8010430e:	8b 40 10             	mov    0x10(%eax),%eax
80104311:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104314:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104317:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010431a:	5b                   	pop    %ebx
8010431b:	5e                   	pop    %esi
8010431c:	5d                   	pop    %ebp
  release(&lk->lk);
8010431d:	e9 8e 02 00 00       	jmp    801045b0 <release>
80104322:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104330 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104330:	55                   	push   %ebp
80104331:	89 e5                	mov    %esp,%ebp
80104333:	56                   	push   %esi
80104334:	53                   	push   %ebx
80104335:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104338:	83 ec 0c             	sub    $0xc,%esp
8010433b:	8d 73 04             	lea    0x4(%ebx),%esi
8010433e:	56                   	push   %esi
8010433f:	e8 4c 01 00 00       	call   80104490 <acquire>
  lk->locked = 0;
80104344:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010434a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104351:	89 1c 24             	mov    %ebx,(%esp)
80104354:	e8 17 fc ff ff       	call   80103f70 <wakeup>
  release(&lk->lk);
80104359:	89 75 08             	mov    %esi,0x8(%ebp)
8010435c:	83 c4 10             	add    $0x10,%esp
}
8010435f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104362:	5b                   	pop    %ebx
80104363:	5e                   	pop    %esi
80104364:	5d                   	pop    %ebp
  release(&lk->lk);
80104365:	e9 46 02 00 00       	jmp    801045b0 <release>
8010436a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104370 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104370:	55                   	push   %ebp
80104371:	89 e5                	mov    %esp,%ebp
80104373:	56                   	push   %esi
80104374:	53                   	push   %ebx
80104375:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
80104378:	83 ec 0c             	sub    $0xc,%esp
8010437b:	8d 5e 04             	lea    0x4(%esi),%ebx
8010437e:	53                   	push   %ebx
8010437f:	e8 0c 01 00 00       	call   80104490 <acquire>
  r = lk->locked;
80104384:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
80104386:	89 1c 24             	mov    %ebx,(%esp)
80104389:	e8 22 02 00 00       	call   801045b0 <release>
  return r;
}
8010438e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104391:	89 f0                	mov    %esi,%eax
80104393:	5b                   	pop    %ebx
80104394:	5e                   	pop    %esi
80104395:	5d                   	pop    %ebp
80104396:	c3                   	ret    
80104397:	66 90                	xchg   %ax,%ax
80104399:	66 90                	xchg   %ax,%ax
8010439b:	66 90                	xchg   %ax,%ax
8010439d:	66 90                	xchg   %ax,%ax
8010439f:	90                   	nop

801043a0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801043a0:	55                   	push   %ebp
801043a1:	89 e5                	mov    %esp,%ebp
801043a3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801043a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801043a9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801043af:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801043b2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801043b9:	5d                   	pop    %ebp
801043ba:	c3                   	ret    
801043bb:	90                   	nop
801043bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801043c0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801043c0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801043c1:	31 d2                	xor    %edx,%edx
{
801043c3:	89 e5                	mov    %esp,%ebp
801043c5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
801043c6:	8b 45 08             	mov    0x8(%ebp),%eax
{
801043c9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
801043cc:	83 e8 08             	sub    $0x8,%eax
801043cf:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801043d0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801043d6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801043dc:	77 1a                	ja     801043f8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
801043de:	8b 58 04             	mov    0x4(%eax),%ebx
801043e1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801043e4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801043e7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801043e9:	83 fa 0a             	cmp    $0xa,%edx
801043ec:	75 e2                	jne    801043d0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801043ee:	5b                   	pop    %ebx
801043ef:	5d                   	pop    %ebp
801043f0:	c3                   	ret    
801043f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043f8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
801043fb:	83 c1 28             	add    $0x28,%ecx
801043fe:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104400:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104406:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104409:	39 c1                	cmp    %eax,%ecx
8010440b:	75 f3                	jne    80104400 <getcallerpcs+0x40>
}
8010440d:	5b                   	pop    %ebx
8010440e:	5d                   	pop    %ebp
8010440f:	c3                   	ret    

80104410 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104410:	55                   	push   %ebp
80104411:	89 e5                	mov    %esp,%ebp
80104413:	53                   	push   %ebx
80104414:	83 ec 04             	sub    $0x4,%esp
80104417:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == mycpu();
8010441a:	8b 02                	mov    (%edx),%eax
8010441c:	85 c0                	test   %eax,%eax
8010441e:	75 10                	jne    80104430 <holding+0x20>
}
80104420:	83 c4 04             	add    $0x4,%esp
80104423:	31 c0                	xor    %eax,%eax
80104425:	5b                   	pop    %ebx
80104426:	5d                   	pop    %ebp
80104427:	c3                   	ret    
80104428:	90                   	nop
80104429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return lock->locked && lock->cpu == mycpu();
80104430:	8b 5a 08             	mov    0x8(%edx),%ebx
80104433:	e8 28 f3 ff ff       	call   80103760 <mycpu>
80104438:	39 c3                	cmp    %eax,%ebx
8010443a:	0f 94 c0             	sete   %al
}
8010443d:	83 c4 04             	add    $0x4,%esp
  return lock->locked && lock->cpu == mycpu();
80104440:	0f b6 c0             	movzbl %al,%eax
}
80104443:	5b                   	pop    %ebx
80104444:	5d                   	pop    %ebp
80104445:	c3                   	ret    
80104446:	8d 76 00             	lea    0x0(%esi),%esi
80104449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104450 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104450:	55                   	push   %ebp
80104451:	89 e5                	mov    %esp,%ebp
80104453:	53                   	push   %ebx
80104454:	83 ec 04             	sub    $0x4,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104457:	9c                   	pushf  
80104458:	5b                   	pop    %ebx
  asm volatile("cli");
80104459:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010445a:	e8 01 f3 ff ff       	call   80103760 <mycpu>
8010445f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104465:	85 c0                	test   %eax,%eax
80104467:	75 11                	jne    8010447a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104469:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010446f:	e8 ec f2 ff ff       	call   80103760 <mycpu>
80104474:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010447a:	e8 e1 f2 ff ff       	call   80103760 <mycpu>
8010447f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104486:	83 c4 04             	add    $0x4,%esp
80104489:	5b                   	pop    %ebx
8010448a:	5d                   	pop    %ebp
8010448b:	c3                   	ret    
8010448c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104490 <acquire>:
{
80104490:	55                   	push   %ebp
80104491:	89 e5                	mov    %esp,%ebp
80104493:	56                   	push   %esi
80104494:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104495:	e8 b6 ff ff ff       	call   80104450 <pushcli>
  if(holding(lk))
8010449a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  return lock->locked && lock->cpu == mycpu();
8010449d:	8b 03                	mov    (%ebx),%eax
8010449f:	85 c0                	test   %eax,%eax
801044a1:	0f 85 81 00 00 00    	jne    80104528 <acquire+0x98>
  asm volatile("lock; xchgl %0, %1" :
801044a7:	ba 01 00 00 00       	mov    $0x1,%edx
801044ac:	eb 05                	jmp    801044b3 <acquire+0x23>
801044ae:	66 90                	xchg   %ax,%ax
801044b0:	8b 5d 08             	mov    0x8(%ebp),%ebx
801044b3:	89 d0                	mov    %edx,%eax
801044b5:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
801044b8:	85 c0                	test   %eax,%eax
801044ba:	75 f4                	jne    801044b0 <acquire+0x20>
  __sync_synchronize();
801044bc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801044c1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801044c4:	e8 97 f2 ff ff       	call   80103760 <mycpu>
  for(i = 0; i < 10; i++){
801044c9:	31 d2                	xor    %edx,%edx
  getcallerpcs(&lk, lk->pcs);
801044cb:	8d 4b 0c             	lea    0xc(%ebx),%ecx
  lk->cpu = mycpu();
801044ce:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
801044d1:	89 e8                	mov    %ebp,%eax
801044d3:	90                   	nop
801044d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801044d8:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801044de:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801044e4:	77 1a                	ja     80104500 <acquire+0x70>
    pcs[i] = ebp[1];     // saved %eip
801044e6:	8b 58 04             	mov    0x4(%eax),%ebx
801044e9:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801044ec:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801044ef:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801044f1:	83 fa 0a             	cmp    $0xa,%edx
801044f4:	75 e2                	jne    801044d8 <acquire+0x48>
}
801044f6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801044f9:	5b                   	pop    %ebx
801044fa:	5e                   	pop    %esi
801044fb:	5d                   	pop    %ebp
801044fc:	c3                   	ret    
801044fd:	8d 76 00             	lea    0x0(%esi),%esi
80104500:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104503:	83 c1 28             	add    $0x28,%ecx
80104506:	8d 76 00             	lea    0x0(%esi),%esi
80104509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80104510:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104516:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104519:	39 c8                	cmp    %ecx,%eax
8010451b:	75 f3                	jne    80104510 <acquire+0x80>
}
8010451d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104520:	5b                   	pop    %ebx
80104521:	5e                   	pop    %esi
80104522:	5d                   	pop    %ebp
80104523:	c3                   	ret    
80104524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return lock->locked && lock->cpu == mycpu();
80104528:	8b 73 08             	mov    0x8(%ebx),%esi
8010452b:	e8 30 f2 ff ff       	call   80103760 <mycpu>
80104530:	39 c6                	cmp    %eax,%esi
80104532:	0f 85 6f ff ff ff    	jne    801044a7 <acquire+0x17>
    panic("acquire");
80104538:	83 ec 0c             	sub    $0xc,%esp
8010453b:	68 37 78 10 80       	push   $0x80107837
80104540:	e8 4b be ff ff       	call   80100390 <panic>
80104545:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104550 <popcli>:

void
popcli(void)
{
80104550:	55                   	push   %ebp
80104551:	89 e5                	mov    %esp,%ebp
80104553:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104556:	9c                   	pushf  
80104557:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104558:	f6 c4 02             	test   $0x2,%ah
8010455b:	75 35                	jne    80104592 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010455d:	e8 fe f1 ff ff       	call   80103760 <mycpu>
80104562:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104569:	78 34                	js     8010459f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010456b:	e8 f0 f1 ff ff       	call   80103760 <mycpu>
80104570:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104576:	85 d2                	test   %edx,%edx
80104578:	74 06                	je     80104580 <popcli+0x30>
    sti();
}
8010457a:	c9                   	leave  
8010457b:	c3                   	ret    
8010457c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104580:	e8 db f1 ff ff       	call   80103760 <mycpu>
80104585:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010458b:	85 c0                	test   %eax,%eax
8010458d:	74 eb                	je     8010457a <popcli+0x2a>
  asm volatile("sti");
8010458f:	fb                   	sti    
}
80104590:	c9                   	leave  
80104591:	c3                   	ret    
    panic("popcli - interruptible");
80104592:	83 ec 0c             	sub    $0xc,%esp
80104595:	68 3f 78 10 80       	push   $0x8010783f
8010459a:	e8 f1 bd ff ff       	call   80100390 <panic>
    panic("popcli");
8010459f:	83 ec 0c             	sub    $0xc,%esp
801045a2:	68 56 78 10 80       	push   $0x80107856
801045a7:	e8 e4 bd ff ff       	call   80100390 <panic>
801045ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801045b0 <release>:
{
801045b0:	55                   	push   %ebp
801045b1:	89 e5                	mov    %esp,%ebp
801045b3:	56                   	push   %esi
801045b4:	53                   	push   %ebx
801045b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  return lock->locked && lock->cpu == mycpu();
801045b8:	8b 03                	mov    (%ebx),%eax
801045ba:	85 c0                	test   %eax,%eax
801045bc:	74 0c                	je     801045ca <release+0x1a>
801045be:	8b 73 08             	mov    0x8(%ebx),%esi
801045c1:	e8 9a f1 ff ff       	call   80103760 <mycpu>
801045c6:	39 c6                	cmp    %eax,%esi
801045c8:	74 16                	je     801045e0 <release+0x30>
    panic("release");
801045ca:	83 ec 0c             	sub    $0xc,%esp
801045cd:	68 5d 78 10 80       	push   $0x8010785d
801045d2:	e8 b9 bd ff ff       	call   80100390 <panic>
801045d7:	89 f6                	mov    %esi,%esi
801045d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lk->pcs[0] = 0;
801045e0:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801045e7:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
801045ee:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801045f3:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
801045f9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801045fc:	5b                   	pop    %ebx
801045fd:	5e                   	pop    %esi
801045fe:	5d                   	pop    %ebp
  popcli();
801045ff:	e9 4c ff ff ff       	jmp    80104550 <popcli>
80104604:	66 90                	xchg   %ax,%ax
80104606:	66 90                	xchg   %ax,%ax
80104608:	66 90                	xchg   %ax,%ax
8010460a:	66 90                	xchg   %ax,%ax
8010460c:	66 90                	xchg   %ax,%ax
8010460e:	66 90                	xchg   %ax,%ax

80104610 <memset>:
80104610:	55                   	push   %ebp
80104611:	89 e5                	mov    %esp,%ebp
80104613:	57                   	push   %edi
80104614:	53                   	push   %ebx
80104615:	8b 55 08             	mov    0x8(%ebp),%edx
80104618:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010461b:	f6 c2 03             	test   $0x3,%dl
8010461e:	75 05                	jne    80104625 <memset+0x15>
80104620:	f6 c1 03             	test   $0x3,%cl
80104623:	74 13                	je     80104638 <memset+0x28>
80104625:	89 d7                	mov    %edx,%edi
80104627:	8b 45 0c             	mov    0xc(%ebp),%eax
8010462a:	fc                   	cld    
8010462b:	f3 aa                	rep stos %al,%es:(%edi)
8010462d:	5b                   	pop    %ebx
8010462e:	89 d0                	mov    %edx,%eax
80104630:	5f                   	pop    %edi
80104631:	5d                   	pop    %ebp
80104632:	c3                   	ret    
80104633:	90                   	nop
80104634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104638:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
8010463c:	c1 e9 02             	shr    $0x2,%ecx
8010463f:	89 fb                	mov    %edi,%ebx
80104641:	89 f8                	mov    %edi,%eax
80104643:	c1 e3 18             	shl    $0x18,%ebx
80104646:	c1 e0 10             	shl    $0x10,%eax
80104649:	09 d8                	or     %ebx,%eax
8010464b:	09 f8                	or     %edi,%eax
8010464d:	c1 e7 08             	shl    $0x8,%edi
80104650:	09 f8                	or     %edi,%eax
80104652:	89 d7                	mov    %edx,%edi
80104654:	fc                   	cld    
80104655:	f3 ab                	rep stos %eax,%es:(%edi)
80104657:	5b                   	pop    %ebx
80104658:	89 d0                	mov    %edx,%eax
8010465a:	5f                   	pop    %edi
8010465b:	5d                   	pop    %ebp
8010465c:	c3                   	ret    
8010465d:	8d 76 00             	lea    0x0(%esi),%esi

80104660 <memcmp>:
80104660:	55                   	push   %ebp
80104661:	89 e5                	mov    %esp,%ebp
80104663:	57                   	push   %edi
80104664:	56                   	push   %esi
80104665:	8b 45 10             	mov    0x10(%ebp),%eax
80104668:	53                   	push   %ebx
80104669:	8b 75 0c             	mov    0xc(%ebp),%esi
8010466c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010466f:	85 c0                	test   %eax,%eax
80104671:	74 29                	je     8010469c <memcmp+0x3c>
80104673:	0f b6 13             	movzbl (%ebx),%edx
80104676:	0f b6 0e             	movzbl (%esi),%ecx
80104679:	38 d1                	cmp    %dl,%cl
8010467b:	75 2b                	jne    801046a8 <memcmp+0x48>
8010467d:	8d 78 ff             	lea    -0x1(%eax),%edi
80104680:	31 c0                	xor    %eax,%eax
80104682:	eb 14                	jmp    80104698 <memcmp+0x38>
80104684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104688:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
8010468d:	83 c0 01             	add    $0x1,%eax
80104690:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104694:	38 ca                	cmp    %cl,%dl
80104696:	75 10                	jne    801046a8 <memcmp+0x48>
80104698:	39 f8                	cmp    %edi,%eax
8010469a:	75 ec                	jne    80104688 <memcmp+0x28>
8010469c:	5b                   	pop    %ebx
8010469d:	31 c0                	xor    %eax,%eax
8010469f:	5e                   	pop    %esi
801046a0:	5f                   	pop    %edi
801046a1:	5d                   	pop    %ebp
801046a2:	c3                   	ret    
801046a3:	90                   	nop
801046a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046a8:	0f b6 c2             	movzbl %dl,%eax
801046ab:	5b                   	pop    %ebx
801046ac:	29 c8                	sub    %ecx,%eax
801046ae:	5e                   	pop    %esi
801046af:	5f                   	pop    %edi
801046b0:	5d                   	pop    %ebp
801046b1:	c3                   	ret    
801046b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046c0 <memmove>:
801046c0:	55                   	push   %ebp
801046c1:	89 e5                	mov    %esp,%ebp
801046c3:	56                   	push   %esi
801046c4:	53                   	push   %ebx
801046c5:	8b 45 08             	mov    0x8(%ebp),%eax
801046c8:	8b 75 0c             	mov    0xc(%ebp),%esi
801046cb:	8b 5d 10             	mov    0x10(%ebp),%ebx
801046ce:	39 c6                	cmp    %eax,%esi
801046d0:	73 2e                	jae    80104700 <memmove+0x40>
801046d2:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
801046d5:	39 c8                	cmp    %ecx,%eax
801046d7:	73 27                	jae    80104700 <memmove+0x40>
801046d9:	85 db                	test   %ebx,%ebx
801046db:	8d 53 ff             	lea    -0x1(%ebx),%edx
801046de:	74 17                	je     801046f7 <memmove+0x37>
801046e0:	29 d9                	sub    %ebx,%ecx
801046e2:	89 cb                	mov    %ecx,%ebx
801046e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046e8:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801046ec:	88 0c 10             	mov    %cl,(%eax,%edx,1)
801046ef:	83 ea 01             	sub    $0x1,%edx
801046f2:	83 fa ff             	cmp    $0xffffffff,%edx
801046f5:	75 f1                	jne    801046e8 <memmove+0x28>
801046f7:	5b                   	pop    %ebx
801046f8:	5e                   	pop    %esi
801046f9:	5d                   	pop    %ebp
801046fa:	c3                   	ret    
801046fb:	90                   	nop
801046fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104700:	31 d2                	xor    %edx,%edx
80104702:	85 db                	test   %ebx,%ebx
80104704:	74 f1                	je     801046f7 <memmove+0x37>
80104706:	8d 76 00             	lea    0x0(%esi),%esi
80104709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104710:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104714:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104717:	83 c2 01             	add    $0x1,%edx
8010471a:	39 d3                	cmp    %edx,%ebx
8010471c:	75 f2                	jne    80104710 <memmove+0x50>
8010471e:	5b                   	pop    %ebx
8010471f:	5e                   	pop    %esi
80104720:	5d                   	pop    %ebp
80104721:	c3                   	ret    
80104722:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104730 <memcpy>:
80104730:	55                   	push   %ebp
80104731:	89 e5                	mov    %esp,%ebp
80104733:	5d                   	pop    %ebp
80104734:	eb 8a                	jmp    801046c0 <memmove>
80104736:	8d 76 00             	lea    0x0(%esi),%esi
80104739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104740 <strncmp>:
80104740:	55                   	push   %ebp
80104741:	89 e5                	mov    %esp,%ebp
80104743:	57                   	push   %edi
80104744:	56                   	push   %esi
80104745:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104748:	53                   	push   %ebx
80104749:	8b 7d 08             	mov    0x8(%ebp),%edi
8010474c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010474f:	85 c9                	test   %ecx,%ecx
80104751:	74 37                	je     8010478a <strncmp+0x4a>
80104753:	0f b6 17             	movzbl (%edi),%edx
80104756:	0f b6 1e             	movzbl (%esi),%ebx
80104759:	84 d2                	test   %dl,%dl
8010475b:	74 3f                	je     8010479c <strncmp+0x5c>
8010475d:	38 d3                	cmp    %dl,%bl
8010475f:	75 3b                	jne    8010479c <strncmp+0x5c>
80104761:	8d 47 01             	lea    0x1(%edi),%eax
80104764:	01 cf                	add    %ecx,%edi
80104766:	eb 1b                	jmp    80104783 <strncmp+0x43>
80104768:	90                   	nop
80104769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104770:	0f b6 10             	movzbl (%eax),%edx
80104773:	84 d2                	test   %dl,%dl
80104775:	74 21                	je     80104798 <strncmp+0x58>
80104777:	0f b6 19             	movzbl (%ecx),%ebx
8010477a:	83 c0 01             	add    $0x1,%eax
8010477d:	89 ce                	mov    %ecx,%esi
8010477f:	38 da                	cmp    %bl,%dl
80104781:	75 19                	jne    8010479c <strncmp+0x5c>
80104783:	39 c7                	cmp    %eax,%edi
80104785:	8d 4e 01             	lea    0x1(%esi),%ecx
80104788:	75 e6                	jne    80104770 <strncmp+0x30>
8010478a:	5b                   	pop    %ebx
8010478b:	31 c0                	xor    %eax,%eax
8010478d:	5e                   	pop    %esi
8010478e:	5f                   	pop    %edi
8010478f:	5d                   	pop    %ebp
80104790:	c3                   	ret    
80104791:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104798:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
8010479c:	0f b6 c2             	movzbl %dl,%eax
8010479f:	29 d8                	sub    %ebx,%eax
801047a1:	5b                   	pop    %ebx
801047a2:	5e                   	pop    %esi
801047a3:	5f                   	pop    %edi
801047a4:	5d                   	pop    %ebp
801047a5:	c3                   	ret    
801047a6:	8d 76 00             	lea    0x0(%esi),%esi
801047a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047b0 <strncpy>:
801047b0:	55                   	push   %ebp
801047b1:	89 e5                	mov    %esp,%ebp
801047b3:	56                   	push   %esi
801047b4:	53                   	push   %ebx
801047b5:	8b 45 08             	mov    0x8(%ebp),%eax
801047b8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801047bb:	8b 4d 10             	mov    0x10(%ebp),%ecx
801047be:	89 c2                	mov    %eax,%edx
801047c0:	eb 19                	jmp    801047db <strncpy+0x2b>
801047c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801047c8:	83 c3 01             	add    $0x1,%ebx
801047cb:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
801047cf:	83 c2 01             	add    $0x1,%edx
801047d2:	84 c9                	test   %cl,%cl
801047d4:	88 4a ff             	mov    %cl,-0x1(%edx)
801047d7:	74 09                	je     801047e2 <strncpy+0x32>
801047d9:	89 f1                	mov    %esi,%ecx
801047db:	85 c9                	test   %ecx,%ecx
801047dd:	8d 71 ff             	lea    -0x1(%ecx),%esi
801047e0:	7f e6                	jg     801047c8 <strncpy+0x18>
801047e2:	31 c9                	xor    %ecx,%ecx
801047e4:	85 f6                	test   %esi,%esi
801047e6:	7e 17                	jle    801047ff <strncpy+0x4f>
801047e8:	90                   	nop
801047e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047f0:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
801047f4:	89 f3                	mov    %esi,%ebx
801047f6:	83 c1 01             	add    $0x1,%ecx
801047f9:	29 cb                	sub    %ecx,%ebx
801047fb:	85 db                	test   %ebx,%ebx
801047fd:	7f f1                	jg     801047f0 <strncpy+0x40>
801047ff:	5b                   	pop    %ebx
80104800:	5e                   	pop    %esi
80104801:	5d                   	pop    %ebp
80104802:	c3                   	ret    
80104803:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104810 <safestrcpy>:
80104810:	55                   	push   %ebp
80104811:	89 e5                	mov    %esp,%ebp
80104813:	56                   	push   %esi
80104814:	53                   	push   %ebx
80104815:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104818:	8b 45 08             	mov    0x8(%ebp),%eax
8010481b:	8b 55 0c             	mov    0xc(%ebp),%edx
8010481e:	85 c9                	test   %ecx,%ecx
80104820:	7e 26                	jle    80104848 <safestrcpy+0x38>
80104822:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104826:	89 c1                	mov    %eax,%ecx
80104828:	eb 17                	jmp    80104841 <safestrcpy+0x31>
8010482a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104830:	83 c2 01             	add    $0x1,%edx
80104833:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104837:	83 c1 01             	add    $0x1,%ecx
8010483a:	84 db                	test   %bl,%bl
8010483c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010483f:	74 04                	je     80104845 <safestrcpy+0x35>
80104841:	39 f2                	cmp    %esi,%edx
80104843:	75 eb                	jne    80104830 <safestrcpy+0x20>
80104845:	c6 01 00             	movb   $0x0,(%ecx)
80104848:	5b                   	pop    %ebx
80104849:	5e                   	pop    %esi
8010484a:	5d                   	pop    %ebp
8010484b:	c3                   	ret    
8010484c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104850 <strlen>:
80104850:	55                   	push   %ebp
80104851:	31 c0                	xor    %eax,%eax
80104853:	89 e5                	mov    %esp,%ebp
80104855:	8b 55 08             	mov    0x8(%ebp),%edx
80104858:	80 3a 00             	cmpb   $0x0,(%edx)
8010485b:	74 0c                	je     80104869 <strlen+0x19>
8010485d:	8d 76 00             	lea    0x0(%esi),%esi
80104860:	83 c0 01             	add    $0x1,%eax
80104863:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104867:	75 f7                	jne    80104860 <strlen+0x10>
80104869:	5d                   	pop    %ebp
8010486a:	c3                   	ret    

8010486b <swtch>:
8010486b:	8b 44 24 04          	mov    0x4(%esp),%eax
8010486f:	8b 54 24 08          	mov    0x8(%esp),%edx
80104873:	55                   	push   %ebp
80104874:	53                   	push   %ebx
80104875:	56                   	push   %esi
80104876:	57                   	push   %edi
80104877:	89 20                	mov    %esp,(%eax)
80104879:	89 d4                	mov    %edx,%esp
8010487b:	5f                   	pop    %edi
8010487c:	5e                   	pop    %esi
8010487d:	5b                   	pop    %ebx
8010487e:	5d                   	pop    %ebp
8010487f:	c3                   	ret    

80104880 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104880:	55                   	push   %ebp
80104881:	89 e5                	mov    %esp,%ebp
80104883:	53                   	push   %ebx
80104884:	83 ec 04             	sub    $0x4,%esp
80104887:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010488a:	e8 71 ef ff ff       	call   80103800 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010488f:	8b 00                	mov    (%eax),%eax
80104891:	39 d8                	cmp    %ebx,%eax
80104893:	76 1b                	jbe    801048b0 <fetchint+0x30>
80104895:	8d 53 04             	lea    0x4(%ebx),%edx
80104898:	39 d0                	cmp    %edx,%eax
8010489a:	72 14                	jb     801048b0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010489c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010489f:	8b 13                	mov    (%ebx),%edx
801048a1:	89 10                	mov    %edx,(%eax)
  return 0;
801048a3:	31 c0                	xor    %eax,%eax
}
801048a5:	83 c4 04             	add    $0x4,%esp
801048a8:	5b                   	pop    %ebx
801048a9:	5d                   	pop    %ebp
801048aa:	c3                   	ret    
801048ab:	90                   	nop
801048ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801048b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801048b5:	eb ee                	jmp    801048a5 <fetchint+0x25>
801048b7:	89 f6                	mov    %esi,%esi
801048b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048c0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801048c0:	55                   	push   %ebp
801048c1:	89 e5                	mov    %esp,%ebp
801048c3:	53                   	push   %ebx
801048c4:	83 ec 04             	sub    $0x4,%esp
801048c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801048ca:	e8 31 ef ff ff       	call   80103800 <myproc>

  if(addr >= curproc->sz)
801048cf:	39 18                	cmp    %ebx,(%eax)
801048d1:	76 29                	jbe    801048fc <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
801048d3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801048d6:	89 da                	mov    %ebx,%edx
801048d8:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
801048da:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
801048dc:	39 c3                	cmp    %eax,%ebx
801048de:	73 1c                	jae    801048fc <fetchstr+0x3c>
    if(*s == 0)
801048e0:	80 3b 00             	cmpb   $0x0,(%ebx)
801048e3:	75 10                	jne    801048f5 <fetchstr+0x35>
801048e5:	eb 39                	jmp    80104920 <fetchstr+0x60>
801048e7:	89 f6                	mov    %esi,%esi
801048e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801048f0:	80 3a 00             	cmpb   $0x0,(%edx)
801048f3:	74 1b                	je     80104910 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
801048f5:	83 c2 01             	add    $0x1,%edx
801048f8:	39 d0                	cmp    %edx,%eax
801048fa:	77 f4                	ja     801048f0 <fetchstr+0x30>
    return -1;
801048fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80104901:	83 c4 04             	add    $0x4,%esp
80104904:	5b                   	pop    %ebx
80104905:	5d                   	pop    %ebp
80104906:	c3                   	ret    
80104907:	89 f6                	mov    %esi,%esi
80104909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104910:	83 c4 04             	add    $0x4,%esp
80104913:	89 d0                	mov    %edx,%eax
80104915:	29 d8                	sub    %ebx,%eax
80104917:	5b                   	pop    %ebx
80104918:	5d                   	pop    %ebp
80104919:	c3                   	ret    
8010491a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80104920:	31 c0                	xor    %eax,%eax
      return s - *pp;
80104922:	eb dd                	jmp    80104901 <fetchstr+0x41>
80104924:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010492a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104930 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104930:	55                   	push   %ebp
80104931:	89 e5                	mov    %esp,%ebp
80104933:	56                   	push   %esi
80104934:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104935:	e8 c6 ee ff ff       	call   80103800 <myproc>
8010493a:	8b 40 18             	mov    0x18(%eax),%eax
8010493d:	8b 55 08             	mov    0x8(%ebp),%edx
80104940:	8b 40 44             	mov    0x44(%eax),%eax
80104943:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104946:	e8 b5 ee ff ff       	call   80103800 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010494b:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010494d:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104950:	39 c6                	cmp    %eax,%esi
80104952:	73 1c                	jae    80104970 <argint+0x40>
80104954:	8d 53 08             	lea    0x8(%ebx),%edx
80104957:	39 d0                	cmp    %edx,%eax
80104959:	72 15                	jb     80104970 <argint+0x40>
  *ip = *(int*)(addr);
8010495b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010495e:	8b 53 04             	mov    0x4(%ebx),%edx
80104961:	89 10                	mov    %edx,(%eax)
  return 0;
80104963:	31 c0                	xor    %eax,%eax
}
80104965:	5b                   	pop    %ebx
80104966:	5e                   	pop    %esi
80104967:	5d                   	pop    %ebp
80104968:	c3                   	ret    
80104969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104970:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104975:	eb ee                	jmp    80104965 <argint+0x35>
80104977:	89 f6                	mov    %esi,%esi
80104979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104980 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104980:	55                   	push   %ebp
80104981:	89 e5                	mov    %esp,%ebp
80104983:	56                   	push   %esi
80104984:	53                   	push   %ebx
80104985:	83 ec 10             	sub    $0x10,%esp
80104988:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010498b:	e8 70 ee ff ff       	call   80103800 <myproc>
80104990:	89 c6                	mov    %eax,%esi

  if(argint(n, &i) < 0)
80104992:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104995:	83 ec 08             	sub    $0x8,%esp
80104998:	50                   	push   %eax
80104999:	ff 75 08             	pushl  0x8(%ebp)
8010499c:	e8 8f ff ff ff       	call   80104930 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801049a1:	83 c4 10             	add    $0x10,%esp
801049a4:	85 c0                	test   %eax,%eax
801049a6:	78 28                	js     801049d0 <argptr+0x50>
801049a8:	85 db                	test   %ebx,%ebx
801049aa:	78 24                	js     801049d0 <argptr+0x50>
801049ac:	8b 16                	mov    (%esi),%edx
801049ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049b1:	39 c2                	cmp    %eax,%edx
801049b3:	76 1b                	jbe    801049d0 <argptr+0x50>
801049b5:	01 c3                	add    %eax,%ebx
801049b7:	39 da                	cmp    %ebx,%edx
801049b9:	72 15                	jb     801049d0 <argptr+0x50>
    return -1;
  *pp = (char*)i;
801049bb:	8b 55 0c             	mov    0xc(%ebp),%edx
801049be:	89 02                	mov    %eax,(%edx)
  return 0;
801049c0:	31 c0                	xor    %eax,%eax
}
801049c2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049c5:	5b                   	pop    %ebx
801049c6:	5e                   	pop    %esi
801049c7:	5d                   	pop    %ebp
801049c8:	c3                   	ret    
801049c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801049d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801049d5:	eb eb                	jmp    801049c2 <argptr+0x42>
801049d7:	89 f6                	mov    %esi,%esi
801049d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049e0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801049e0:	55                   	push   %ebp
801049e1:	89 e5                	mov    %esp,%ebp
801049e3:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
801049e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801049e9:	50                   	push   %eax
801049ea:	ff 75 08             	pushl  0x8(%ebp)
801049ed:	e8 3e ff ff ff       	call   80104930 <argint>
801049f2:	83 c4 10             	add    $0x10,%esp
801049f5:	85 c0                	test   %eax,%eax
801049f7:	78 17                	js     80104a10 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
801049f9:	83 ec 08             	sub    $0x8,%esp
801049fc:	ff 75 0c             	pushl  0xc(%ebp)
801049ff:	ff 75 f4             	pushl  -0xc(%ebp)
80104a02:	e8 b9 fe ff ff       	call   801048c0 <fetchstr>
80104a07:	83 c4 10             	add    $0x10,%esp
}
80104a0a:	c9                   	leave  
80104a0b:	c3                   	ret    
80104a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104a10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104a15:	c9                   	leave  
80104a16:	c3                   	ret    
80104a17:	89 f6                	mov    %esi,%esi
80104a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a20 <syscall>:
[SYS_getprocinfo] sys_getprocinfo,
};

void
syscall(void)
{
80104a20:	55                   	push   %ebp
80104a21:	89 e5                	mov    %esp,%ebp
80104a23:	53                   	push   %ebx
80104a24:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104a27:	e8 d4 ed ff ff       	call   80103800 <myproc>
80104a2c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104a2e:	8b 40 18             	mov    0x18(%eax),%eax
80104a31:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104a34:	8d 50 ff             	lea    -0x1(%eax),%edx
80104a37:	83 fa 17             	cmp    $0x17,%edx
80104a3a:	77 1c                	ja     80104a58 <syscall+0x38>
80104a3c:	8b 14 85 a0 78 10 80 	mov    -0x7fef8760(,%eax,4),%edx
80104a43:	85 d2                	test   %edx,%edx
80104a45:	74 11                	je     80104a58 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104a47:	ff d2                	call   *%edx
80104a49:	8b 53 18             	mov    0x18(%ebx),%edx
80104a4c:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104a4f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a52:	c9                   	leave  
80104a53:	c3                   	ret    
80104a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104a58:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104a59:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104a5c:	50                   	push   %eax
80104a5d:	ff 73 10             	pushl  0x10(%ebx)
80104a60:	68 65 78 10 80       	push   $0x80107865
80104a65:	e8 f6 bb ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
80104a6a:	8b 43 18             	mov    0x18(%ebx),%eax
80104a6d:	83 c4 10             	add    $0x10,%esp
80104a70:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104a77:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a7a:	c9                   	leave  
80104a7b:	c3                   	ret    
80104a7c:	66 90                	xchg   %ax,%ax
80104a7e:	66 90                	xchg   %ax,%ax

80104a80 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104a80:	55                   	push   %ebp
80104a81:	89 e5                	mov    %esp,%ebp
80104a83:	57                   	push   %edi
80104a84:	56                   	push   %esi
80104a85:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104a86:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80104a89:	83 ec 44             	sub    $0x44,%esp
80104a8c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104a8f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104a92:	56                   	push   %esi
80104a93:	50                   	push   %eax
{
80104a94:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104a97:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104a9a:	e8 71 d4 ff ff       	call   80101f10 <nameiparent>
80104a9f:	83 c4 10             	add    $0x10,%esp
80104aa2:	85 c0                	test   %eax,%eax
80104aa4:	0f 84 46 01 00 00    	je     80104bf0 <create+0x170>
    return 0;
  ilock(dp);
80104aaa:	83 ec 0c             	sub    $0xc,%esp
80104aad:	89 c3                	mov    %eax,%ebx
80104aaf:	50                   	push   %eax
80104ab0:	e8 db cb ff ff       	call   80101690 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104ab5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104ab8:	83 c4 0c             	add    $0xc,%esp
80104abb:	50                   	push   %eax
80104abc:	56                   	push   %esi
80104abd:	53                   	push   %ebx
80104abe:	e8 fd d0 ff ff       	call   80101bc0 <dirlookup>
80104ac3:	83 c4 10             	add    $0x10,%esp
80104ac6:	85 c0                	test   %eax,%eax
80104ac8:	89 c7                	mov    %eax,%edi
80104aca:	74 34                	je     80104b00 <create+0x80>
    iunlockput(dp);
80104acc:	83 ec 0c             	sub    $0xc,%esp
80104acf:	53                   	push   %ebx
80104ad0:	e8 4b ce ff ff       	call   80101920 <iunlockput>
    ilock(ip);
80104ad5:	89 3c 24             	mov    %edi,(%esp)
80104ad8:	e8 b3 cb ff ff       	call   80101690 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104add:	83 c4 10             	add    $0x10,%esp
80104ae0:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104ae5:	0f 85 95 00 00 00    	jne    80104b80 <create+0x100>
80104aeb:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104af0:	0f 85 8a 00 00 00    	jne    80104b80 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104af6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104af9:	89 f8                	mov    %edi,%eax
80104afb:	5b                   	pop    %ebx
80104afc:	5e                   	pop    %esi
80104afd:	5f                   	pop    %edi
80104afe:	5d                   	pop    %ebp
80104aff:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
80104b00:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104b04:	83 ec 08             	sub    $0x8,%esp
80104b07:	50                   	push   %eax
80104b08:	ff 33                	pushl  (%ebx)
80104b0a:	e8 11 ca ff ff       	call   80101520 <ialloc>
80104b0f:	83 c4 10             	add    $0x10,%esp
80104b12:	85 c0                	test   %eax,%eax
80104b14:	89 c7                	mov    %eax,%edi
80104b16:	0f 84 e8 00 00 00    	je     80104c04 <create+0x184>
  ilock(ip);
80104b1c:	83 ec 0c             	sub    $0xc,%esp
80104b1f:	50                   	push   %eax
80104b20:	e8 6b cb ff ff       	call   80101690 <ilock>
  ip->major = major;
80104b25:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104b29:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104b2d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104b31:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104b35:	b8 01 00 00 00       	mov    $0x1,%eax
80104b3a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104b3e:	89 3c 24             	mov    %edi,(%esp)
80104b41:	e8 9a ca ff ff       	call   801015e0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104b46:	83 c4 10             	add    $0x10,%esp
80104b49:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104b4e:	74 50                	je     80104ba0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104b50:	83 ec 04             	sub    $0x4,%esp
80104b53:	ff 77 04             	pushl  0x4(%edi)
80104b56:	56                   	push   %esi
80104b57:	53                   	push   %ebx
80104b58:	e8 d3 d2 ff ff       	call   80101e30 <dirlink>
80104b5d:	83 c4 10             	add    $0x10,%esp
80104b60:	85 c0                	test   %eax,%eax
80104b62:	0f 88 8f 00 00 00    	js     80104bf7 <create+0x177>
  iunlockput(dp);
80104b68:	83 ec 0c             	sub    $0xc,%esp
80104b6b:	53                   	push   %ebx
80104b6c:	e8 af cd ff ff       	call   80101920 <iunlockput>
  return ip;
80104b71:	83 c4 10             	add    $0x10,%esp
}
80104b74:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b77:	89 f8                	mov    %edi,%eax
80104b79:	5b                   	pop    %ebx
80104b7a:	5e                   	pop    %esi
80104b7b:	5f                   	pop    %edi
80104b7c:	5d                   	pop    %ebp
80104b7d:	c3                   	ret    
80104b7e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80104b80:	83 ec 0c             	sub    $0xc,%esp
80104b83:	57                   	push   %edi
    return 0;
80104b84:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80104b86:	e8 95 cd ff ff       	call   80101920 <iunlockput>
    return 0;
80104b8b:	83 c4 10             	add    $0x10,%esp
}
80104b8e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b91:	89 f8                	mov    %edi,%eax
80104b93:	5b                   	pop    %ebx
80104b94:	5e                   	pop    %esi
80104b95:	5f                   	pop    %edi
80104b96:	5d                   	pop    %ebp
80104b97:	c3                   	ret    
80104b98:	90                   	nop
80104b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80104ba0:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104ba5:	83 ec 0c             	sub    $0xc,%esp
80104ba8:	53                   	push   %ebx
80104ba9:	e8 32 ca ff ff       	call   801015e0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104bae:	83 c4 0c             	add    $0xc,%esp
80104bb1:	ff 77 04             	pushl  0x4(%edi)
80104bb4:	68 20 79 10 80       	push   $0x80107920
80104bb9:	57                   	push   %edi
80104bba:	e8 71 d2 ff ff       	call   80101e30 <dirlink>
80104bbf:	83 c4 10             	add    $0x10,%esp
80104bc2:	85 c0                	test   %eax,%eax
80104bc4:	78 1c                	js     80104be2 <create+0x162>
80104bc6:	83 ec 04             	sub    $0x4,%esp
80104bc9:	ff 73 04             	pushl  0x4(%ebx)
80104bcc:	68 1f 79 10 80       	push   $0x8010791f
80104bd1:	57                   	push   %edi
80104bd2:	e8 59 d2 ff ff       	call   80101e30 <dirlink>
80104bd7:	83 c4 10             	add    $0x10,%esp
80104bda:	85 c0                	test   %eax,%eax
80104bdc:	0f 89 6e ff ff ff    	jns    80104b50 <create+0xd0>
      panic("create dots");
80104be2:	83 ec 0c             	sub    $0xc,%esp
80104be5:	68 13 79 10 80       	push   $0x80107913
80104bea:	e8 a1 b7 ff ff       	call   80100390 <panic>
80104bef:	90                   	nop
    return 0;
80104bf0:	31 ff                	xor    %edi,%edi
80104bf2:	e9 ff fe ff ff       	jmp    80104af6 <create+0x76>
    panic("create: dirlink");
80104bf7:	83 ec 0c             	sub    $0xc,%esp
80104bfa:	68 22 79 10 80       	push   $0x80107922
80104bff:	e8 8c b7 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80104c04:	83 ec 0c             	sub    $0xc,%esp
80104c07:	68 04 79 10 80       	push   $0x80107904
80104c0c:	e8 7f b7 ff ff       	call   80100390 <panic>
80104c11:	eb 0d                	jmp    80104c20 <argfd.constprop.0>
80104c13:	90                   	nop
80104c14:	90                   	nop
80104c15:	90                   	nop
80104c16:	90                   	nop
80104c17:	90                   	nop
80104c18:	90                   	nop
80104c19:	90                   	nop
80104c1a:	90                   	nop
80104c1b:	90                   	nop
80104c1c:	90                   	nop
80104c1d:	90                   	nop
80104c1e:	90                   	nop
80104c1f:	90                   	nop

80104c20 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104c20:	55                   	push   %ebp
80104c21:	89 e5                	mov    %esp,%ebp
80104c23:	56                   	push   %esi
80104c24:	53                   	push   %ebx
80104c25:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80104c27:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104c2a:	89 d6                	mov    %edx,%esi
80104c2c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104c2f:	50                   	push   %eax
80104c30:	6a 00                	push   $0x0
80104c32:	e8 f9 fc ff ff       	call   80104930 <argint>
80104c37:	83 c4 10             	add    $0x10,%esp
80104c3a:	85 c0                	test   %eax,%eax
80104c3c:	78 2a                	js     80104c68 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104c3e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104c42:	77 24                	ja     80104c68 <argfd.constprop.0+0x48>
80104c44:	e8 b7 eb ff ff       	call   80103800 <myproc>
80104c49:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104c4c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104c50:	85 c0                	test   %eax,%eax
80104c52:	74 14                	je     80104c68 <argfd.constprop.0+0x48>
  if(pfd)
80104c54:	85 db                	test   %ebx,%ebx
80104c56:	74 02                	je     80104c5a <argfd.constprop.0+0x3a>
    *pfd = fd;
80104c58:	89 13                	mov    %edx,(%ebx)
    *pf = f;
80104c5a:	89 06                	mov    %eax,(%esi)
  return 0;
80104c5c:	31 c0                	xor    %eax,%eax
}
80104c5e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c61:	5b                   	pop    %ebx
80104c62:	5e                   	pop    %esi
80104c63:	5d                   	pop    %ebp
80104c64:	c3                   	ret    
80104c65:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104c68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c6d:	eb ef                	jmp    80104c5e <argfd.constprop.0+0x3e>
80104c6f:	90                   	nop

80104c70 <sys_dup>:
{
80104c70:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104c71:	31 c0                	xor    %eax,%eax
{
80104c73:	89 e5                	mov    %esp,%ebp
80104c75:	56                   	push   %esi
80104c76:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104c77:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104c7a:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80104c7d:	e8 9e ff ff ff       	call   80104c20 <argfd.constprop.0>
80104c82:	85 c0                	test   %eax,%eax
80104c84:	78 42                	js     80104cc8 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
80104c86:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104c89:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80104c8b:	e8 70 eb ff ff       	call   80103800 <myproc>
80104c90:	eb 0e                	jmp    80104ca0 <sys_dup+0x30>
80104c92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104c98:	83 c3 01             	add    $0x1,%ebx
80104c9b:	83 fb 10             	cmp    $0x10,%ebx
80104c9e:	74 28                	je     80104cc8 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80104ca0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104ca4:	85 d2                	test   %edx,%edx
80104ca6:	75 f0                	jne    80104c98 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80104ca8:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104cac:	83 ec 0c             	sub    $0xc,%esp
80104caf:	ff 75 f4             	pushl  -0xc(%ebp)
80104cb2:	e8 39 c1 ff ff       	call   80100df0 <filedup>
  return fd;
80104cb7:	83 c4 10             	add    $0x10,%esp
}
80104cba:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104cbd:	89 d8                	mov    %ebx,%eax
80104cbf:	5b                   	pop    %ebx
80104cc0:	5e                   	pop    %esi
80104cc1:	5d                   	pop    %ebp
80104cc2:	c3                   	ret    
80104cc3:	90                   	nop
80104cc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104cc8:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104ccb:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104cd0:	89 d8                	mov    %ebx,%eax
80104cd2:	5b                   	pop    %ebx
80104cd3:	5e                   	pop    %esi
80104cd4:	5d                   	pop    %ebp
80104cd5:	c3                   	ret    
80104cd6:	8d 76 00             	lea    0x0(%esi),%esi
80104cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ce0 <sys_read>:
{
80104ce0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104ce1:	31 c0                	xor    %eax,%eax
{
80104ce3:	89 e5                	mov    %esp,%ebp
80104ce5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104ce8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104ceb:	e8 30 ff ff ff       	call   80104c20 <argfd.constprop.0>
80104cf0:	85 c0                	test   %eax,%eax
80104cf2:	78 4c                	js     80104d40 <sys_read+0x60>
80104cf4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104cf7:	83 ec 08             	sub    $0x8,%esp
80104cfa:	50                   	push   %eax
80104cfb:	6a 02                	push   $0x2
80104cfd:	e8 2e fc ff ff       	call   80104930 <argint>
80104d02:	83 c4 10             	add    $0x10,%esp
80104d05:	85 c0                	test   %eax,%eax
80104d07:	78 37                	js     80104d40 <sys_read+0x60>
80104d09:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d0c:	83 ec 04             	sub    $0x4,%esp
80104d0f:	ff 75 f0             	pushl  -0x10(%ebp)
80104d12:	50                   	push   %eax
80104d13:	6a 01                	push   $0x1
80104d15:	e8 66 fc ff ff       	call   80104980 <argptr>
80104d1a:	83 c4 10             	add    $0x10,%esp
80104d1d:	85 c0                	test   %eax,%eax
80104d1f:	78 1f                	js     80104d40 <sys_read+0x60>
  return fileread(f, p, n);
80104d21:	83 ec 04             	sub    $0x4,%esp
80104d24:	ff 75 f0             	pushl  -0x10(%ebp)
80104d27:	ff 75 f4             	pushl  -0xc(%ebp)
80104d2a:	ff 75 ec             	pushl  -0x14(%ebp)
80104d2d:	e8 2e c2 ff ff       	call   80100f60 <fileread>
80104d32:	83 c4 10             	add    $0x10,%esp
}
80104d35:	c9                   	leave  
80104d36:	c3                   	ret    
80104d37:	89 f6                	mov    %esi,%esi
80104d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104d40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d45:	c9                   	leave  
80104d46:	c3                   	ret    
80104d47:	89 f6                	mov    %esi,%esi
80104d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d50 <sys_write>:
{
80104d50:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d51:	31 c0                	xor    %eax,%eax
{
80104d53:	89 e5                	mov    %esp,%ebp
80104d55:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d58:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104d5b:	e8 c0 fe ff ff       	call   80104c20 <argfd.constprop.0>
80104d60:	85 c0                	test   %eax,%eax
80104d62:	78 4c                	js     80104db0 <sys_write+0x60>
80104d64:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d67:	83 ec 08             	sub    $0x8,%esp
80104d6a:	50                   	push   %eax
80104d6b:	6a 02                	push   $0x2
80104d6d:	e8 be fb ff ff       	call   80104930 <argint>
80104d72:	83 c4 10             	add    $0x10,%esp
80104d75:	85 c0                	test   %eax,%eax
80104d77:	78 37                	js     80104db0 <sys_write+0x60>
80104d79:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d7c:	83 ec 04             	sub    $0x4,%esp
80104d7f:	ff 75 f0             	pushl  -0x10(%ebp)
80104d82:	50                   	push   %eax
80104d83:	6a 01                	push   $0x1
80104d85:	e8 f6 fb ff ff       	call   80104980 <argptr>
80104d8a:	83 c4 10             	add    $0x10,%esp
80104d8d:	85 c0                	test   %eax,%eax
80104d8f:	78 1f                	js     80104db0 <sys_write+0x60>
  return filewrite(f, p, n);
80104d91:	83 ec 04             	sub    $0x4,%esp
80104d94:	ff 75 f0             	pushl  -0x10(%ebp)
80104d97:	ff 75 f4             	pushl  -0xc(%ebp)
80104d9a:	ff 75 ec             	pushl  -0x14(%ebp)
80104d9d:	e8 4e c2 ff ff       	call   80100ff0 <filewrite>
80104da2:	83 c4 10             	add    $0x10,%esp
}
80104da5:	c9                   	leave  
80104da6:	c3                   	ret    
80104da7:	89 f6                	mov    %esi,%esi
80104da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104db0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104db5:	c9                   	leave  
80104db6:	c3                   	ret    
80104db7:	89 f6                	mov    %esi,%esi
80104db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104dc0 <sys_close>:
{
80104dc0:	55                   	push   %ebp
80104dc1:	89 e5                	mov    %esp,%ebp
80104dc3:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80104dc6:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104dc9:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104dcc:	e8 4f fe ff ff       	call   80104c20 <argfd.constprop.0>
80104dd1:	85 c0                	test   %eax,%eax
80104dd3:	78 2b                	js     80104e00 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80104dd5:	e8 26 ea ff ff       	call   80103800 <myproc>
80104dda:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104ddd:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80104de0:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104de7:	00 
  fileclose(f);
80104de8:	ff 75 f4             	pushl  -0xc(%ebp)
80104deb:	e8 50 c0 ff ff       	call   80100e40 <fileclose>
  return 0;
80104df0:	83 c4 10             	add    $0x10,%esp
80104df3:	31 c0                	xor    %eax,%eax
}
80104df5:	c9                   	leave  
80104df6:	c3                   	ret    
80104df7:	89 f6                	mov    %esi,%esi
80104df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104e00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e05:	c9                   	leave  
80104e06:	c3                   	ret    
80104e07:	89 f6                	mov    %esi,%esi
80104e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e10 <sys_fstat>:
{
80104e10:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104e11:	31 c0                	xor    %eax,%eax
{
80104e13:	89 e5                	mov    %esp,%ebp
80104e15:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104e18:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104e1b:	e8 00 fe ff ff       	call   80104c20 <argfd.constprop.0>
80104e20:	85 c0                	test   %eax,%eax
80104e22:	78 2c                	js     80104e50 <sys_fstat+0x40>
80104e24:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e27:	83 ec 04             	sub    $0x4,%esp
80104e2a:	6a 14                	push   $0x14
80104e2c:	50                   	push   %eax
80104e2d:	6a 01                	push   $0x1
80104e2f:	e8 4c fb ff ff       	call   80104980 <argptr>
80104e34:	83 c4 10             	add    $0x10,%esp
80104e37:	85 c0                	test   %eax,%eax
80104e39:	78 15                	js     80104e50 <sys_fstat+0x40>
  return filestat(f, st);
80104e3b:	83 ec 08             	sub    $0x8,%esp
80104e3e:	ff 75 f4             	pushl  -0xc(%ebp)
80104e41:	ff 75 f0             	pushl  -0x10(%ebp)
80104e44:	e8 c7 c0 ff ff       	call   80100f10 <filestat>
80104e49:	83 c4 10             	add    $0x10,%esp
}
80104e4c:	c9                   	leave  
80104e4d:	c3                   	ret    
80104e4e:	66 90                	xchg   %ax,%ax
    return -1;
80104e50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e55:	c9                   	leave  
80104e56:	c3                   	ret    
80104e57:	89 f6                	mov    %esi,%esi
80104e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e60 <sys_link>:
{
80104e60:	55                   	push   %ebp
80104e61:	89 e5                	mov    %esp,%ebp
80104e63:	57                   	push   %edi
80104e64:	56                   	push   %esi
80104e65:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104e66:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80104e69:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104e6c:	50                   	push   %eax
80104e6d:	6a 00                	push   $0x0
80104e6f:	e8 6c fb ff ff       	call   801049e0 <argstr>
80104e74:	83 c4 10             	add    $0x10,%esp
80104e77:	85 c0                	test   %eax,%eax
80104e79:	0f 88 fb 00 00 00    	js     80104f7a <sys_link+0x11a>
80104e7f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104e82:	83 ec 08             	sub    $0x8,%esp
80104e85:	50                   	push   %eax
80104e86:	6a 01                	push   $0x1
80104e88:	e8 53 fb ff ff       	call   801049e0 <argstr>
80104e8d:	83 c4 10             	add    $0x10,%esp
80104e90:	85 c0                	test   %eax,%eax
80104e92:	0f 88 e2 00 00 00    	js     80104f7a <sys_link+0x11a>
  begin_op();
80104e98:	e8 13 dd ff ff       	call   80102bb0 <begin_op>
  if((ip = namei(old)) == 0){
80104e9d:	83 ec 0c             	sub    $0xc,%esp
80104ea0:	ff 75 d4             	pushl  -0x2c(%ebp)
80104ea3:	e8 48 d0 ff ff       	call   80101ef0 <namei>
80104ea8:	83 c4 10             	add    $0x10,%esp
80104eab:	85 c0                	test   %eax,%eax
80104ead:	89 c3                	mov    %eax,%ebx
80104eaf:	0f 84 ea 00 00 00    	je     80104f9f <sys_link+0x13f>
  ilock(ip);
80104eb5:	83 ec 0c             	sub    $0xc,%esp
80104eb8:	50                   	push   %eax
80104eb9:	e8 d2 c7 ff ff       	call   80101690 <ilock>
  if(ip->type == T_DIR){
80104ebe:	83 c4 10             	add    $0x10,%esp
80104ec1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104ec6:	0f 84 bb 00 00 00    	je     80104f87 <sys_link+0x127>
  ip->nlink++;
80104ecc:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104ed1:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80104ed4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80104ed7:	53                   	push   %ebx
80104ed8:	e8 03 c7 ff ff       	call   801015e0 <iupdate>
  iunlock(ip);
80104edd:	89 1c 24             	mov    %ebx,(%esp)
80104ee0:	e8 8b c8 ff ff       	call   80101770 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80104ee5:	58                   	pop    %eax
80104ee6:	5a                   	pop    %edx
80104ee7:	57                   	push   %edi
80104ee8:	ff 75 d0             	pushl  -0x30(%ebp)
80104eeb:	e8 20 d0 ff ff       	call   80101f10 <nameiparent>
80104ef0:	83 c4 10             	add    $0x10,%esp
80104ef3:	85 c0                	test   %eax,%eax
80104ef5:	89 c6                	mov    %eax,%esi
80104ef7:	74 5b                	je     80104f54 <sys_link+0xf4>
  ilock(dp);
80104ef9:	83 ec 0c             	sub    $0xc,%esp
80104efc:	50                   	push   %eax
80104efd:	e8 8e c7 ff ff       	call   80101690 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104f02:	83 c4 10             	add    $0x10,%esp
80104f05:	8b 03                	mov    (%ebx),%eax
80104f07:	39 06                	cmp    %eax,(%esi)
80104f09:	75 3d                	jne    80104f48 <sys_link+0xe8>
80104f0b:	83 ec 04             	sub    $0x4,%esp
80104f0e:	ff 73 04             	pushl  0x4(%ebx)
80104f11:	57                   	push   %edi
80104f12:	56                   	push   %esi
80104f13:	e8 18 cf ff ff       	call   80101e30 <dirlink>
80104f18:	83 c4 10             	add    $0x10,%esp
80104f1b:	85 c0                	test   %eax,%eax
80104f1d:	78 29                	js     80104f48 <sys_link+0xe8>
  iunlockput(dp);
80104f1f:	83 ec 0c             	sub    $0xc,%esp
80104f22:	56                   	push   %esi
80104f23:	e8 f8 c9 ff ff       	call   80101920 <iunlockput>
  iput(ip);
80104f28:	89 1c 24             	mov    %ebx,(%esp)
80104f2b:	e8 90 c8 ff ff       	call   801017c0 <iput>
  end_op();
80104f30:	e8 eb dc ff ff       	call   80102c20 <end_op>
  return 0;
80104f35:	83 c4 10             	add    $0x10,%esp
80104f38:	31 c0                	xor    %eax,%eax
}
80104f3a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f3d:	5b                   	pop    %ebx
80104f3e:	5e                   	pop    %esi
80104f3f:	5f                   	pop    %edi
80104f40:	5d                   	pop    %ebp
80104f41:	c3                   	ret    
80104f42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80104f48:	83 ec 0c             	sub    $0xc,%esp
80104f4b:	56                   	push   %esi
80104f4c:	e8 cf c9 ff ff       	call   80101920 <iunlockput>
    goto bad;
80104f51:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80104f54:	83 ec 0c             	sub    $0xc,%esp
80104f57:	53                   	push   %ebx
80104f58:	e8 33 c7 ff ff       	call   80101690 <ilock>
  ip->nlink--;
80104f5d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104f62:	89 1c 24             	mov    %ebx,(%esp)
80104f65:	e8 76 c6 ff ff       	call   801015e0 <iupdate>
  iunlockput(ip);
80104f6a:	89 1c 24             	mov    %ebx,(%esp)
80104f6d:	e8 ae c9 ff ff       	call   80101920 <iunlockput>
  end_op();
80104f72:	e8 a9 dc ff ff       	call   80102c20 <end_op>
  return -1;
80104f77:	83 c4 10             	add    $0x10,%esp
}
80104f7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80104f7d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f82:	5b                   	pop    %ebx
80104f83:	5e                   	pop    %esi
80104f84:	5f                   	pop    %edi
80104f85:	5d                   	pop    %ebp
80104f86:	c3                   	ret    
    iunlockput(ip);
80104f87:	83 ec 0c             	sub    $0xc,%esp
80104f8a:	53                   	push   %ebx
80104f8b:	e8 90 c9 ff ff       	call   80101920 <iunlockput>
    end_op();
80104f90:	e8 8b dc ff ff       	call   80102c20 <end_op>
    return -1;
80104f95:	83 c4 10             	add    $0x10,%esp
80104f98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f9d:	eb 9b                	jmp    80104f3a <sys_link+0xda>
    end_op();
80104f9f:	e8 7c dc ff ff       	call   80102c20 <end_op>
    return -1;
80104fa4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fa9:	eb 8f                	jmp    80104f3a <sys_link+0xda>
80104fab:	90                   	nop
80104fac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104fb0 <sys_unlink>:
{
80104fb0:	55                   	push   %ebp
80104fb1:	89 e5                	mov    %esp,%ebp
80104fb3:	57                   	push   %edi
80104fb4:	56                   	push   %esi
80104fb5:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80104fb6:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80104fb9:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
80104fbc:	50                   	push   %eax
80104fbd:	6a 00                	push   $0x0
80104fbf:	e8 1c fa ff ff       	call   801049e0 <argstr>
80104fc4:	83 c4 10             	add    $0x10,%esp
80104fc7:	85 c0                	test   %eax,%eax
80104fc9:	0f 88 77 01 00 00    	js     80105146 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
80104fcf:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80104fd2:	e8 d9 db ff ff       	call   80102bb0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104fd7:	83 ec 08             	sub    $0x8,%esp
80104fda:	53                   	push   %ebx
80104fdb:	ff 75 c0             	pushl  -0x40(%ebp)
80104fde:	e8 2d cf ff ff       	call   80101f10 <nameiparent>
80104fe3:	83 c4 10             	add    $0x10,%esp
80104fe6:	85 c0                	test   %eax,%eax
80104fe8:	89 c6                	mov    %eax,%esi
80104fea:	0f 84 60 01 00 00    	je     80105150 <sys_unlink+0x1a0>
  ilock(dp);
80104ff0:	83 ec 0c             	sub    $0xc,%esp
80104ff3:	50                   	push   %eax
80104ff4:	e8 97 c6 ff ff       	call   80101690 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104ff9:	58                   	pop    %eax
80104ffa:	5a                   	pop    %edx
80104ffb:	68 20 79 10 80       	push   $0x80107920
80105000:	53                   	push   %ebx
80105001:	e8 9a cb ff ff       	call   80101ba0 <namecmp>
80105006:	83 c4 10             	add    $0x10,%esp
80105009:	85 c0                	test   %eax,%eax
8010500b:	0f 84 03 01 00 00    	je     80105114 <sys_unlink+0x164>
80105011:	83 ec 08             	sub    $0x8,%esp
80105014:	68 1f 79 10 80       	push   $0x8010791f
80105019:	53                   	push   %ebx
8010501a:	e8 81 cb ff ff       	call   80101ba0 <namecmp>
8010501f:	83 c4 10             	add    $0x10,%esp
80105022:	85 c0                	test   %eax,%eax
80105024:	0f 84 ea 00 00 00    	je     80105114 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010502a:	8d 45 c4             	lea    -0x3c(%ebp),%eax
8010502d:	83 ec 04             	sub    $0x4,%esp
80105030:	50                   	push   %eax
80105031:	53                   	push   %ebx
80105032:	56                   	push   %esi
80105033:	e8 88 cb ff ff       	call   80101bc0 <dirlookup>
80105038:	83 c4 10             	add    $0x10,%esp
8010503b:	85 c0                	test   %eax,%eax
8010503d:	89 c3                	mov    %eax,%ebx
8010503f:	0f 84 cf 00 00 00    	je     80105114 <sys_unlink+0x164>
  ilock(ip);
80105045:	83 ec 0c             	sub    $0xc,%esp
80105048:	50                   	push   %eax
80105049:	e8 42 c6 ff ff       	call   80101690 <ilock>
  if(ip->nlink < 1)
8010504e:	83 c4 10             	add    $0x10,%esp
80105051:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105056:	0f 8e 10 01 00 00    	jle    8010516c <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
8010505c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105061:	74 6d                	je     801050d0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105063:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105066:	83 ec 04             	sub    $0x4,%esp
80105069:	6a 10                	push   $0x10
8010506b:	6a 00                	push   $0x0
8010506d:	50                   	push   %eax
8010506e:	e8 9d f5 ff ff       	call   80104610 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105073:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105076:	6a 10                	push   $0x10
80105078:	ff 75 c4             	pushl  -0x3c(%ebp)
8010507b:	50                   	push   %eax
8010507c:	56                   	push   %esi
8010507d:	e8 ee c9 ff ff       	call   80101a70 <writei>
80105082:	83 c4 20             	add    $0x20,%esp
80105085:	83 f8 10             	cmp    $0x10,%eax
80105088:	0f 85 eb 00 00 00    	jne    80105179 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
8010508e:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105093:	0f 84 97 00 00 00    	je     80105130 <sys_unlink+0x180>
  iunlockput(dp);
80105099:	83 ec 0c             	sub    $0xc,%esp
8010509c:	56                   	push   %esi
8010509d:	e8 7e c8 ff ff       	call   80101920 <iunlockput>
  ip->nlink--;
801050a2:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801050a7:	89 1c 24             	mov    %ebx,(%esp)
801050aa:	e8 31 c5 ff ff       	call   801015e0 <iupdate>
  iunlockput(ip);
801050af:	89 1c 24             	mov    %ebx,(%esp)
801050b2:	e8 69 c8 ff ff       	call   80101920 <iunlockput>
  end_op();
801050b7:	e8 64 db ff ff       	call   80102c20 <end_op>
  return 0;
801050bc:	83 c4 10             	add    $0x10,%esp
801050bf:	31 c0                	xor    %eax,%eax
}
801050c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801050c4:	5b                   	pop    %ebx
801050c5:	5e                   	pop    %esi
801050c6:	5f                   	pop    %edi
801050c7:	5d                   	pop    %ebp
801050c8:	c3                   	ret    
801050c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801050d0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801050d4:	76 8d                	jbe    80105063 <sys_unlink+0xb3>
801050d6:	bf 20 00 00 00       	mov    $0x20,%edi
801050db:	eb 0f                	jmp    801050ec <sys_unlink+0x13c>
801050dd:	8d 76 00             	lea    0x0(%esi),%esi
801050e0:	83 c7 10             	add    $0x10,%edi
801050e3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801050e6:	0f 83 77 ff ff ff    	jae    80105063 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801050ec:	8d 45 d8             	lea    -0x28(%ebp),%eax
801050ef:	6a 10                	push   $0x10
801050f1:	57                   	push   %edi
801050f2:	50                   	push   %eax
801050f3:	53                   	push   %ebx
801050f4:	e8 77 c8 ff ff       	call   80101970 <readi>
801050f9:	83 c4 10             	add    $0x10,%esp
801050fc:	83 f8 10             	cmp    $0x10,%eax
801050ff:	75 5e                	jne    8010515f <sys_unlink+0x1af>
    if(de.inum != 0)
80105101:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105106:	74 d8                	je     801050e0 <sys_unlink+0x130>
    iunlockput(ip);
80105108:	83 ec 0c             	sub    $0xc,%esp
8010510b:	53                   	push   %ebx
8010510c:	e8 0f c8 ff ff       	call   80101920 <iunlockput>
    goto bad;
80105111:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
80105114:	83 ec 0c             	sub    $0xc,%esp
80105117:	56                   	push   %esi
80105118:	e8 03 c8 ff ff       	call   80101920 <iunlockput>
  end_op();
8010511d:	e8 fe da ff ff       	call   80102c20 <end_op>
  return -1;
80105122:	83 c4 10             	add    $0x10,%esp
80105125:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010512a:	eb 95                	jmp    801050c1 <sys_unlink+0x111>
8010512c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80105130:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105135:	83 ec 0c             	sub    $0xc,%esp
80105138:	56                   	push   %esi
80105139:	e8 a2 c4 ff ff       	call   801015e0 <iupdate>
8010513e:	83 c4 10             	add    $0x10,%esp
80105141:	e9 53 ff ff ff       	jmp    80105099 <sys_unlink+0xe9>
    return -1;
80105146:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010514b:	e9 71 ff ff ff       	jmp    801050c1 <sys_unlink+0x111>
    end_op();
80105150:	e8 cb da ff ff       	call   80102c20 <end_op>
    return -1;
80105155:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010515a:	e9 62 ff ff ff       	jmp    801050c1 <sys_unlink+0x111>
      panic("isdirempty: readi");
8010515f:	83 ec 0c             	sub    $0xc,%esp
80105162:	68 44 79 10 80       	push   $0x80107944
80105167:	e8 24 b2 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
8010516c:	83 ec 0c             	sub    $0xc,%esp
8010516f:	68 32 79 10 80       	push   $0x80107932
80105174:	e8 17 b2 ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80105179:	83 ec 0c             	sub    $0xc,%esp
8010517c:	68 56 79 10 80       	push   $0x80107956
80105181:	e8 0a b2 ff ff       	call   80100390 <panic>
80105186:	8d 76 00             	lea    0x0(%esi),%esi
80105189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105190 <sys_open>:

int
sys_open(void)
{
80105190:	55                   	push   %ebp
80105191:	89 e5                	mov    %esp,%ebp
80105193:	57                   	push   %edi
80105194:	56                   	push   %esi
80105195:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105196:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105199:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010519c:	50                   	push   %eax
8010519d:	6a 00                	push   $0x0
8010519f:	e8 3c f8 ff ff       	call   801049e0 <argstr>
801051a4:	83 c4 10             	add    $0x10,%esp
801051a7:	85 c0                	test   %eax,%eax
801051a9:	0f 88 1d 01 00 00    	js     801052cc <sys_open+0x13c>
801051af:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801051b2:	83 ec 08             	sub    $0x8,%esp
801051b5:	50                   	push   %eax
801051b6:	6a 01                	push   $0x1
801051b8:	e8 73 f7 ff ff       	call   80104930 <argint>
801051bd:	83 c4 10             	add    $0x10,%esp
801051c0:	85 c0                	test   %eax,%eax
801051c2:	0f 88 04 01 00 00    	js     801052cc <sys_open+0x13c>
    return -1;

  begin_op();
801051c8:	e8 e3 d9 ff ff       	call   80102bb0 <begin_op>

  if(omode & O_CREATE){
801051cd:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801051d1:	0f 85 a9 00 00 00    	jne    80105280 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801051d7:	83 ec 0c             	sub    $0xc,%esp
801051da:	ff 75 e0             	pushl  -0x20(%ebp)
801051dd:	e8 0e cd ff ff       	call   80101ef0 <namei>
801051e2:	83 c4 10             	add    $0x10,%esp
801051e5:	85 c0                	test   %eax,%eax
801051e7:	89 c6                	mov    %eax,%esi
801051e9:	0f 84 b2 00 00 00    	je     801052a1 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
801051ef:	83 ec 0c             	sub    $0xc,%esp
801051f2:	50                   	push   %eax
801051f3:	e8 98 c4 ff ff       	call   80101690 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801051f8:	83 c4 10             	add    $0x10,%esp
801051fb:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105200:	0f 84 aa 00 00 00    	je     801052b0 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105206:	e8 75 bb ff ff       	call   80100d80 <filealloc>
8010520b:	85 c0                	test   %eax,%eax
8010520d:	89 c7                	mov    %eax,%edi
8010520f:	0f 84 a6 00 00 00    	je     801052bb <sys_open+0x12b>
  struct proc *curproc = myproc();
80105215:	e8 e6 e5 ff ff       	call   80103800 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010521a:	31 db                	xor    %ebx,%ebx
8010521c:	eb 0e                	jmp    8010522c <sys_open+0x9c>
8010521e:	66 90                	xchg   %ax,%ax
80105220:	83 c3 01             	add    $0x1,%ebx
80105223:	83 fb 10             	cmp    $0x10,%ebx
80105226:	0f 84 ac 00 00 00    	je     801052d8 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
8010522c:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105230:	85 d2                	test   %edx,%edx
80105232:	75 ec                	jne    80105220 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105234:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105237:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
8010523b:	56                   	push   %esi
8010523c:	e8 2f c5 ff ff       	call   80101770 <iunlock>
  end_op();
80105241:	e8 da d9 ff ff       	call   80102c20 <end_op>

  f->type = FD_INODE;
80105246:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
8010524c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010524f:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105252:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105255:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010525c:	89 d0                	mov    %edx,%eax
8010525e:	f7 d0                	not    %eax
80105260:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105263:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105266:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105269:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
8010526d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105270:	89 d8                	mov    %ebx,%eax
80105272:	5b                   	pop    %ebx
80105273:	5e                   	pop    %esi
80105274:	5f                   	pop    %edi
80105275:	5d                   	pop    %ebp
80105276:	c3                   	ret    
80105277:	89 f6                	mov    %esi,%esi
80105279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
80105280:	83 ec 0c             	sub    $0xc,%esp
80105283:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105286:	31 c9                	xor    %ecx,%ecx
80105288:	6a 00                	push   $0x0
8010528a:	ba 02 00 00 00       	mov    $0x2,%edx
8010528f:	e8 ec f7 ff ff       	call   80104a80 <create>
    if(ip == 0){
80105294:	83 c4 10             	add    $0x10,%esp
80105297:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105299:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010529b:	0f 85 65 ff ff ff    	jne    80105206 <sys_open+0x76>
      end_op();
801052a1:	e8 7a d9 ff ff       	call   80102c20 <end_op>
      return -1;
801052a6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801052ab:	eb c0                	jmp    8010526d <sys_open+0xdd>
801052ad:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
801052b0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801052b3:	85 c9                	test   %ecx,%ecx
801052b5:	0f 84 4b ff ff ff    	je     80105206 <sys_open+0x76>
    iunlockput(ip);
801052bb:	83 ec 0c             	sub    $0xc,%esp
801052be:	56                   	push   %esi
801052bf:	e8 5c c6 ff ff       	call   80101920 <iunlockput>
    end_op();
801052c4:	e8 57 d9 ff ff       	call   80102c20 <end_op>
    return -1;
801052c9:	83 c4 10             	add    $0x10,%esp
801052cc:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801052d1:	eb 9a                	jmp    8010526d <sys_open+0xdd>
801052d3:	90                   	nop
801052d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
801052d8:	83 ec 0c             	sub    $0xc,%esp
801052db:	57                   	push   %edi
801052dc:	e8 5f bb ff ff       	call   80100e40 <fileclose>
801052e1:	83 c4 10             	add    $0x10,%esp
801052e4:	eb d5                	jmp    801052bb <sys_open+0x12b>
801052e6:	8d 76 00             	lea    0x0(%esi),%esi
801052e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801052f0 <sys_mkdir>:

int
sys_mkdir(void)
{
801052f0:	55                   	push   %ebp
801052f1:	89 e5                	mov    %esp,%ebp
801052f3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801052f6:	e8 b5 d8 ff ff       	call   80102bb0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801052fb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801052fe:	83 ec 08             	sub    $0x8,%esp
80105301:	50                   	push   %eax
80105302:	6a 00                	push   $0x0
80105304:	e8 d7 f6 ff ff       	call   801049e0 <argstr>
80105309:	83 c4 10             	add    $0x10,%esp
8010530c:	85 c0                	test   %eax,%eax
8010530e:	78 30                	js     80105340 <sys_mkdir+0x50>
80105310:	83 ec 0c             	sub    $0xc,%esp
80105313:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105316:	31 c9                	xor    %ecx,%ecx
80105318:	6a 00                	push   $0x0
8010531a:	ba 01 00 00 00       	mov    $0x1,%edx
8010531f:	e8 5c f7 ff ff       	call   80104a80 <create>
80105324:	83 c4 10             	add    $0x10,%esp
80105327:	85 c0                	test   %eax,%eax
80105329:	74 15                	je     80105340 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010532b:	83 ec 0c             	sub    $0xc,%esp
8010532e:	50                   	push   %eax
8010532f:	e8 ec c5 ff ff       	call   80101920 <iunlockput>
  end_op();
80105334:	e8 e7 d8 ff ff       	call   80102c20 <end_op>
  return 0;
80105339:	83 c4 10             	add    $0x10,%esp
8010533c:	31 c0                	xor    %eax,%eax
}
8010533e:	c9                   	leave  
8010533f:	c3                   	ret    
    end_op();
80105340:	e8 db d8 ff ff       	call   80102c20 <end_op>
    return -1;
80105345:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010534a:	c9                   	leave  
8010534b:	c3                   	ret    
8010534c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105350 <sys_mknod>:

int
sys_mknod(void)
{
80105350:	55                   	push   %ebp
80105351:	89 e5                	mov    %esp,%ebp
80105353:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105356:	e8 55 d8 ff ff       	call   80102bb0 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010535b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010535e:	83 ec 08             	sub    $0x8,%esp
80105361:	50                   	push   %eax
80105362:	6a 00                	push   $0x0
80105364:	e8 77 f6 ff ff       	call   801049e0 <argstr>
80105369:	83 c4 10             	add    $0x10,%esp
8010536c:	85 c0                	test   %eax,%eax
8010536e:	78 60                	js     801053d0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105370:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105373:	83 ec 08             	sub    $0x8,%esp
80105376:	50                   	push   %eax
80105377:	6a 01                	push   $0x1
80105379:	e8 b2 f5 ff ff       	call   80104930 <argint>
  if((argstr(0, &path)) < 0 ||
8010537e:	83 c4 10             	add    $0x10,%esp
80105381:	85 c0                	test   %eax,%eax
80105383:	78 4b                	js     801053d0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105385:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105388:	83 ec 08             	sub    $0x8,%esp
8010538b:	50                   	push   %eax
8010538c:	6a 02                	push   $0x2
8010538e:	e8 9d f5 ff ff       	call   80104930 <argint>
     argint(1, &major) < 0 ||
80105393:	83 c4 10             	add    $0x10,%esp
80105396:	85 c0                	test   %eax,%eax
80105398:	78 36                	js     801053d0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010539a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
8010539e:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
801053a1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
801053a5:	ba 03 00 00 00       	mov    $0x3,%edx
801053aa:	50                   	push   %eax
801053ab:	8b 45 ec             	mov    -0x14(%ebp),%eax
801053ae:	e8 cd f6 ff ff       	call   80104a80 <create>
801053b3:	83 c4 10             	add    $0x10,%esp
801053b6:	85 c0                	test   %eax,%eax
801053b8:	74 16                	je     801053d0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
801053ba:	83 ec 0c             	sub    $0xc,%esp
801053bd:	50                   	push   %eax
801053be:	e8 5d c5 ff ff       	call   80101920 <iunlockput>
  end_op();
801053c3:	e8 58 d8 ff ff       	call   80102c20 <end_op>
  return 0;
801053c8:	83 c4 10             	add    $0x10,%esp
801053cb:	31 c0                	xor    %eax,%eax
}
801053cd:	c9                   	leave  
801053ce:	c3                   	ret    
801053cf:	90                   	nop
    end_op();
801053d0:	e8 4b d8 ff ff       	call   80102c20 <end_op>
    return -1;
801053d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801053da:	c9                   	leave  
801053db:	c3                   	ret    
801053dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801053e0 <sys_chdir>:

int
sys_chdir(void)
{
801053e0:	55                   	push   %ebp
801053e1:	89 e5                	mov    %esp,%ebp
801053e3:	56                   	push   %esi
801053e4:	53                   	push   %ebx
801053e5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801053e8:	e8 13 e4 ff ff       	call   80103800 <myproc>
801053ed:	89 c6                	mov    %eax,%esi
  
  begin_op();
801053ef:	e8 bc d7 ff ff       	call   80102bb0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801053f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053f7:	83 ec 08             	sub    $0x8,%esp
801053fa:	50                   	push   %eax
801053fb:	6a 00                	push   $0x0
801053fd:	e8 de f5 ff ff       	call   801049e0 <argstr>
80105402:	83 c4 10             	add    $0x10,%esp
80105405:	85 c0                	test   %eax,%eax
80105407:	78 77                	js     80105480 <sys_chdir+0xa0>
80105409:	83 ec 0c             	sub    $0xc,%esp
8010540c:	ff 75 f4             	pushl  -0xc(%ebp)
8010540f:	e8 dc ca ff ff       	call   80101ef0 <namei>
80105414:	83 c4 10             	add    $0x10,%esp
80105417:	85 c0                	test   %eax,%eax
80105419:	89 c3                	mov    %eax,%ebx
8010541b:	74 63                	je     80105480 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010541d:	83 ec 0c             	sub    $0xc,%esp
80105420:	50                   	push   %eax
80105421:	e8 6a c2 ff ff       	call   80101690 <ilock>
  if(ip->type != T_DIR){
80105426:	83 c4 10             	add    $0x10,%esp
80105429:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010542e:	75 30                	jne    80105460 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105430:	83 ec 0c             	sub    $0xc,%esp
80105433:	53                   	push   %ebx
80105434:	e8 37 c3 ff ff       	call   80101770 <iunlock>
  iput(curproc->cwd);
80105439:	58                   	pop    %eax
8010543a:	ff 76 68             	pushl  0x68(%esi)
8010543d:	e8 7e c3 ff ff       	call   801017c0 <iput>
  end_op();
80105442:	e8 d9 d7 ff ff       	call   80102c20 <end_op>
  curproc->cwd = ip;
80105447:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010544a:	83 c4 10             	add    $0x10,%esp
8010544d:	31 c0                	xor    %eax,%eax
}
8010544f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105452:	5b                   	pop    %ebx
80105453:	5e                   	pop    %esi
80105454:	5d                   	pop    %ebp
80105455:	c3                   	ret    
80105456:	8d 76 00             	lea    0x0(%esi),%esi
80105459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80105460:	83 ec 0c             	sub    $0xc,%esp
80105463:	53                   	push   %ebx
80105464:	e8 b7 c4 ff ff       	call   80101920 <iunlockput>
    end_op();
80105469:	e8 b2 d7 ff ff       	call   80102c20 <end_op>
    return -1;
8010546e:	83 c4 10             	add    $0x10,%esp
80105471:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105476:	eb d7                	jmp    8010544f <sys_chdir+0x6f>
80105478:	90                   	nop
80105479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105480:	e8 9b d7 ff ff       	call   80102c20 <end_op>
    return -1;
80105485:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010548a:	eb c3                	jmp    8010544f <sys_chdir+0x6f>
8010548c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105490 <sys_exec>:

int
sys_exec(void)
{
80105490:	55                   	push   %ebp
80105491:	89 e5                	mov    %esp,%ebp
80105493:	57                   	push   %edi
80105494:	56                   	push   %esi
80105495:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105496:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010549c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801054a2:	50                   	push   %eax
801054a3:	6a 00                	push   $0x0
801054a5:	e8 36 f5 ff ff       	call   801049e0 <argstr>
801054aa:	83 c4 10             	add    $0x10,%esp
801054ad:	85 c0                	test   %eax,%eax
801054af:	0f 88 87 00 00 00    	js     8010553c <sys_exec+0xac>
801054b5:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801054bb:	83 ec 08             	sub    $0x8,%esp
801054be:	50                   	push   %eax
801054bf:	6a 01                	push   $0x1
801054c1:	e8 6a f4 ff ff       	call   80104930 <argint>
801054c6:	83 c4 10             	add    $0x10,%esp
801054c9:	85 c0                	test   %eax,%eax
801054cb:	78 6f                	js     8010553c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801054cd:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801054d3:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
801054d6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801054d8:	68 80 00 00 00       	push   $0x80
801054dd:	6a 00                	push   $0x0
801054df:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801054e5:	50                   	push   %eax
801054e6:	e8 25 f1 ff ff       	call   80104610 <memset>
801054eb:	83 c4 10             	add    $0x10,%esp
801054ee:	eb 2c                	jmp    8010551c <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
801054f0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801054f6:	85 c0                	test   %eax,%eax
801054f8:	74 56                	je     80105550 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801054fa:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105500:	83 ec 08             	sub    $0x8,%esp
80105503:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105506:	52                   	push   %edx
80105507:	50                   	push   %eax
80105508:	e8 b3 f3 ff ff       	call   801048c0 <fetchstr>
8010550d:	83 c4 10             	add    $0x10,%esp
80105510:	85 c0                	test   %eax,%eax
80105512:	78 28                	js     8010553c <sys_exec+0xac>
  for(i=0;; i++){
80105514:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105517:	83 fb 20             	cmp    $0x20,%ebx
8010551a:	74 20                	je     8010553c <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
8010551c:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105522:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105529:	83 ec 08             	sub    $0x8,%esp
8010552c:	57                   	push   %edi
8010552d:	01 f0                	add    %esi,%eax
8010552f:	50                   	push   %eax
80105530:	e8 4b f3 ff ff       	call   80104880 <fetchint>
80105535:	83 c4 10             	add    $0x10,%esp
80105538:	85 c0                	test   %eax,%eax
8010553a:	79 b4                	jns    801054f0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010553c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010553f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105544:	5b                   	pop    %ebx
80105545:	5e                   	pop    %esi
80105546:	5f                   	pop    %edi
80105547:	5d                   	pop    %ebp
80105548:	c3                   	ret    
80105549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105550:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105556:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80105559:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105560:	00 00 00 00 
  return exec(path, argv);
80105564:	50                   	push   %eax
80105565:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010556b:	e8 a0 b4 ff ff       	call   80100a10 <exec>
80105570:	83 c4 10             	add    $0x10,%esp
}
80105573:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105576:	5b                   	pop    %ebx
80105577:	5e                   	pop    %esi
80105578:	5f                   	pop    %edi
80105579:	5d                   	pop    %ebp
8010557a:	c3                   	ret    
8010557b:	90                   	nop
8010557c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105580 <sys_pipe>:

int
sys_pipe(void)
{
80105580:	55                   	push   %ebp
80105581:	89 e5                	mov    %esp,%ebp
80105583:	57                   	push   %edi
80105584:	56                   	push   %esi
80105585:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105586:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105589:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010558c:	6a 08                	push   $0x8
8010558e:	50                   	push   %eax
8010558f:	6a 00                	push   $0x0
80105591:	e8 ea f3 ff ff       	call   80104980 <argptr>
80105596:	83 c4 10             	add    $0x10,%esp
80105599:	85 c0                	test   %eax,%eax
8010559b:	0f 88 ae 00 00 00    	js     8010564f <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801055a1:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801055a4:	83 ec 08             	sub    $0x8,%esp
801055a7:	50                   	push   %eax
801055a8:	8d 45 e0             	lea    -0x20(%ebp),%eax
801055ab:	50                   	push   %eax
801055ac:	e8 9f dc ff ff       	call   80103250 <pipealloc>
801055b1:	83 c4 10             	add    $0x10,%esp
801055b4:	85 c0                	test   %eax,%eax
801055b6:	0f 88 93 00 00 00    	js     8010564f <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801055bc:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801055bf:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801055c1:	e8 3a e2 ff ff       	call   80103800 <myproc>
801055c6:	eb 10                	jmp    801055d8 <sys_pipe+0x58>
801055c8:	90                   	nop
801055c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
801055d0:	83 c3 01             	add    $0x1,%ebx
801055d3:	83 fb 10             	cmp    $0x10,%ebx
801055d6:	74 60                	je     80105638 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
801055d8:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801055dc:	85 f6                	test   %esi,%esi
801055de:	75 f0                	jne    801055d0 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
801055e0:	8d 73 08             	lea    0x8(%ebx),%esi
801055e3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801055e7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801055ea:	e8 11 e2 ff ff       	call   80103800 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801055ef:	31 d2                	xor    %edx,%edx
801055f1:	eb 0d                	jmp    80105600 <sys_pipe+0x80>
801055f3:	90                   	nop
801055f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801055f8:	83 c2 01             	add    $0x1,%edx
801055fb:	83 fa 10             	cmp    $0x10,%edx
801055fe:	74 28                	je     80105628 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
80105600:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105604:	85 c9                	test   %ecx,%ecx
80105606:	75 f0                	jne    801055f8 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
80105608:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
8010560c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010560f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105611:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105614:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105617:	31 c0                	xor    %eax,%eax
}
80105619:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010561c:	5b                   	pop    %ebx
8010561d:	5e                   	pop    %esi
8010561e:	5f                   	pop    %edi
8010561f:	5d                   	pop    %ebp
80105620:	c3                   	ret    
80105621:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
80105628:	e8 d3 e1 ff ff       	call   80103800 <myproc>
8010562d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105634:	00 
80105635:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
80105638:	83 ec 0c             	sub    $0xc,%esp
8010563b:	ff 75 e0             	pushl  -0x20(%ebp)
8010563e:	e8 fd b7 ff ff       	call   80100e40 <fileclose>
    fileclose(wf);
80105643:	58                   	pop    %eax
80105644:	ff 75 e4             	pushl  -0x1c(%ebp)
80105647:	e8 f4 b7 ff ff       	call   80100e40 <fileclose>
    return -1;
8010564c:	83 c4 10             	add    $0x10,%esp
8010564f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105654:	eb c3                	jmp    80105619 <sys_pipe+0x99>
80105656:	66 90                	xchg   %ax,%ax
80105658:	66 90                	xchg   %ax,%ax
8010565a:	66 90                	xchg   %ax,%ax
8010565c:	66 90                	xchg   %ax,%ax
8010565e:	66 90                	xchg   %ax,%ax

80105660 <sys_fork>:
#include "proc.h"
#include "processInfo.h"

int
sys_fork(void)
{
80105660:	55                   	push   %ebp
80105661:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105663:	5d                   	pop    %ebp
  return fork();
80105664:	e9 37 e3 ff ff       	jmp    801039a0 <fork>
80105669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105670 <sys_exit>:

int
sys_exit(void)
{
80105670:	55                   	push   %ebp
80105671:	89 e5                	mov    %esp,%ebp
80105673:	83 ec 08             	sub    $0x8,%esp
  exit();
80105676:	e8 c5 e5 ff ff       	call   80103c40 <exit>
  return 0;  // not reached
}
8010567b:	31 c0                	xor    %eax,%eax
8010567d:	c9                   	leave  
8010567e:	c3                   	ret    
8010567f:	90                   	nop

80105680 <sys_wait>:

int
sys_wait(void)
{
80105680:	55                   	push   %ebp
80105681:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105683:	5d                   	pop    %ebp
  return wait();
80105684:	e9 f7 e7 ff ff       	jmp    80103e80 <wait>
80105689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105690 <sys_kill>:

int
sys_kill(void)
{
80105690:	55                   	push   %ebp
80105691:	89 e5                	mov    %esp,%ebp
80105693:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105696:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105699:	50                   	push   %eax
8010569a:	6a 00                	push   $0x0
8010569c:	e8 8f f2 ff ff       	call   80104930 <argint>
801056a1:	83 c4 10             	add    $0x10,%esp
801056a4:	85 c0                	test   %eax,%eax
801056a6:	78 18                	js     801056c0 <sys_kill+0x30>
    return -1;
  return kill(pid);
801056a8:	83 ec 0c             	sub    $0xc,%esp
801056ab:	ff 75 f4             	pushl  -0xc(%ebp)
801056ae:	e8 1d e9 ff ff       	call   80103fd0 <kill>
801056b3:	83 c4 10             	add    $0x10,%esp
}
801056b6:	c9                   	leave  
801056b7:	c3                   	ret    
801056b8:	90                   	nop
801056b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801056c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801056c5:	c9                   	leave  
801056c6:	c3                   	ret    
801056c7:	89 f6                	mov    %esi,%esi
801056c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801056d0 <sys_getpid>:

int
sys_getpid(void)
{
801056d0:	55                   	push   %ebp
801056d1:	89 e5                	mov    %esp,%ebp
801056d3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801056d6:	e8 25 e1 ff ff       	call   80103800 <myproc>
801056db:	8b 40 10             	mov    0x10(%eax),%eax
}
801056de:	c9                   	leave  
801056df:	c3                   	ret    

801056e0 <sys_sbrk>:

int
sys_sbrk(void)
{
801056e0:	55                   	push   %ebp
801056e1:	89 e5                	mov    %esp,%ebp
801056e3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801056e4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801056e7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801056ea:	50                   	push   %eax
801056eb:	6a 00                	push   $0x0
801056ed:	e8 3e f2 ff ff       	call   80104930 <argint>
801056f2:	83 c4 10             	add    $0x10,%esp
801056f5:	85 c0                	test   %eax,%eax
801056f7:	78 27                	js     80105720 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801056f9:	e8 02 e1 ff ff       	call   80103800 <myproc>
  if(growproc(n) < 0)
801056fe:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105701:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105703:	ff 75 f4             	pushl  -0xc(%ebp)
80105706:	e8 15 e2 ff ff       	call   80103920 <growproc>
8010570b:	83 c4 10             	add    $0x10,%esp
8010570e:	85 c0                	test   %eax,%eax
80105710:	78 0e                	js     80105720 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105712:	89 d8                	mov    %ebx,%eax
80105714:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105717:	c9                   	leave  
80105718:	c3                   	ret    
80105719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105720:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105725:	eb eb                	jmp    80105712 <sys_sbrk+0x32>
80105727:	89 f6                	mov    %esi,%esi
80105729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105730 <sys_sleep>:

int
sys_sleep(void)
{
80105730:	55                   	push   %ebp
80105731:	89 e5                	mov    %esp,%ebp
80105733:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105734:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105737:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010573a:	50                   	push   %eax
8010573b:	6a 00                	push   $0x0
8010573d:	e8 ee f1 ff ff       	call   80104930 <argint>
80105742:	83 c4 10             	add    $0x10,%esp
80105745:	85 c0                	test   %eax,%eax
80105747:	0f 88 8a 00 00 00    	js     801057d7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010574d:	83 ec 0c             	sub    $0xc,%esp
80105750:	68 60 4d 11 80       	push   $0x80114d60
80105755:	e8 36 ed ff ff       	call   80104490 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010575a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010575d:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105760:	8b 1d a0 55 11 80    	mov    0x801155a0,%ebx
  while(ticks - ticks0 < n){
80105766:	85 d2                	test   %edx,%edx
80105768:	75 27                	jne    80105791 <sys_sleep+0x61>
8010576a:	eb 54                	jmp    801057c0 <sys_sleep+0x90>
8010576c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105770:	83 ec 08             	sub    $0x8,%esp
80105773:	68 60 4d 11 80       	push   $0x80114d60
80105778:	68 a0 55 11 80       	push   $0x801155a0
8010577d:	e8 3e e6 ff ff       	call   80103dc0 <sleep>
  while(ticks - ticks0 < n){
80105782:	a1 a0 55 11 80       	mov    0x801155a0,%eax
80105787:	83 c4 10             	add    $0x10,%esp
8010578a:	29 d8                	sub    %ebx,%eax
8010578c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010578f:	73 2f                	jae    801057c0 <sys_sleep+0x90>
    if(myproc()->killed){
80105791:	e8 6a e0 ff ff       	call   80103800 <myproc>
80105796:	8b 40 24             	mov    0x24(%eax),%eax
80105799:	85 c0                	test   %eax,%eax
8010579b:	74 d3                	je     80105770 <sys_sleep+0x40>
      release(&tickslock);
8010579d:	83 ec 0c             	sub    $0xc,%esp
801057a0:	68 60 4d 11 80       	push   $0x80114d60
801057a5:	e8 06 ee ff ff       	call   801045b0 <release>
      return -1;
801057aa:	83 c4 10             	add    $0x10,%esp
801057ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
801057b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057b5:	c9                   	leave  
801057b6:	c3                   	ret    
801057b7:	89 f6                	mov    %esi,%esi
801057b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
801057c0:	83 ec 0c             	sub    $0xc,%esp
801057c3:	68 60 4d 11 80       	push   $0x80114d60
801057c8:	e8 e3 ed ff ff       	call   801045b0 <release>
  return 0;
801057cd:	83 c4 10             	add    $0x10,%esp
801057d0:	31 c0                	xor    %eax,%eax
}
801057d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057d5:	c9                   	leave  
801057d6:	c3                   	ret    
    return -1;
801057d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057dc:	eb f4                	jmp    801057d2 <sys_sleep+0xa2>
801057de:	66 90                	xchg   %ax,%ax

801057e0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801057e0:	55                   	push   %ebp
801057e1:	89 e5                	mov    %esp,%ebp
801057e3:	53                   	push   %ebx
801057e4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801057e7:	68 60 4d 11 80       	push   $0x80114d60
801057ec:	e8 9f ec ff ff       	call   80104490 <acquire>
  xticks = ticks;
801057f1:	8b 1d a0 55 11 80    	mov    0x801155a0,%ebx
  release(&tickslock);
801057f7:	c7 04 24 60 4d 11 80 	movl   $0x80114d60,(%esp)
801057fe:	e8 ad ed ff ff       	call   801045b0 <release>
  return xticks;
}
80105803:	89 d8                	mov    %ebx,%eax
80105805:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105808:	c9                   	leave  
80105809:	c3                   	ret    
8010580a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105810 <sys_cps>:


//CPS system call
int
sys_cps(void)
{
80105810:	55                   	push   %ebp
80105811:	89 e5                	mov    %esp,%ebp
   return cps();
}
80105813:	5d                   	pop    %ebp
   return cps();
80105814:	e9 f7 e8 ff ff       	jmp    80104110 <cps>
80105819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105820 <sys_chpr>:

//Change priority system call
int
sys_chpr (void)
{
80105820:	55                   	push   %ebp
80105821:	89 e5                	mov    %esp,%ebp
80105823:	83 ec 20             	sub    $0x20,%esp
	int pid, pr;

	if(argint(0, &pid) < 0)
80105826:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105829:	50                   	push   %eax
8010582a:	6a 00                	push   $0x0
8010582c:	e8 ff f0 ff ff       	call   80104930 <argint>
80105831:	83 c4 10             	add    $0x10,%esp
80105834:	85 c0                	test   %eax,%eax
80105836:	78 28                	js     80105860 <sys_chpr+0x40>
		return -1;
	if(argint(1, &pr) < 0)
80105838:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010583b:	83 ec 08             	sub    $0x8,%esp
8010583e:	50                   	push   %eax
8010583f:	6a 01                	push   $0x1
80105841:	e8 ea f0 ff ff       	call   80104930 <argint>
80105846:	83 c4 10             	add    $0x10,%esp
80105849:	85 c0                	test   %eax,%eax
8010584b:	78 13                	js     80105860 <sys_chpr+0x40>
		return -1;
	return chpr ( pid, pr );
8010584d:	83 ec 08             	sub    $0x8,%esp
80105850:	ff 75 f4             	pushl  -0xc(%ebp)
80105853:	ff 75 f0             	pushl  -0x10(%ebp)
80105856:	e8 85 e9 ff ff       	call   801041e0 <chpr>
8010585b:	83 c4 10             	add    $0x10,%esp
}
8010585e:	c9                   	leave  
8010585f:	c3                   	ret    
		return -1;
80105860:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105865:	c9                   	leave  
80105866:	c3                   	ret    
80105867:	89 f6                	mov    %esi,%esi
80105869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105870 <sys_getprocinfo>:


//
int
sys_getprocinfo(void)
{
80105870:	55                   	push   %ebp
80105871:	89 e5                	mov    %esp,%ebp
80105873:	83 ec 20             	sub    $0x20,%esp
    int pid;
    struct processInfo *procInfo;

    if(argint(0, &pid) < 0)
80105876:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105879:	50                   	push   %eax
8010587a:	6a 00                	push   $0x0
8010587c:	e8 af f0 ff ff       	call   80104930 <argint>
80105881:	83 c4 10             	add    $0x10,%esp
80105884:	85 c0                	test   %eax,%eax
80105886:	78 30                	js     801058b8 <sys_getprocinfo+0x48>
        return -1;
    if(argptr(1, (void *)&procInfo, sizeof(procInfo)) < 0)
80105888:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010588b:	83 ec 04             	sub    $0x4,%esp
8010588e:	6a 04                	push   $0x4
80105890:	50                   	push   %eax
80105891:	6a 01                	push   $0x1
80105893:	e8 e8 f0 ff ff       	call   80104980 <argptr>
80105898:	83 c4 10             	add    $0x10,%esp
8010589b:	85 c0                	test   %eax,%eax
8010589d:	78 19                	js     801058b8 <sys_getprocinfo+0x48>
        return -1;

    return getprocinfo(pid, procInfo);
8010589f:	83 ec 08             	sub    $0x8,%esp
801058a2:	ff 75 f4             	pushl  -0xc(%ebp)
801058a5:	ff 75 f0             	pushl  -0x10(%ebp)
801058a8:	e8 83 e9 ff ff       	call   80104230 <getprocinfo>
801058ad:	83 c4 10             	add    $0x10,%esp

}
801058b0:	c9                   	leave  
801058b1:	c3                   	ret    
801058b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
801058b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801058bd:	c9                   	leave  
801058be:	c3                   	ret    

801058bf <alltraps>:
801058bf:	1e                   	push   %ds
801058c0:	06                   	push   %es
801058c1:	0f a0                	push   %fs
801058c3:	0f a8                	push   %gs
801058c5:	60                   	pusha  
801058c6:	66 b8 10 00          	mov    $0x10,%ax
801058ca:	8e d8                	mov    %eax,%ds
801058cc:	8e c0                	mov    %eax,%es
801058ce:	54                   	push   %esp
801058cf:	e8 cc 00 00 00       	call   801059a0 <trap>
801058d4:	83 c4 04             	add    $0x4,%esp

801058d7 <trapret>:
801058d7:	61                   	popa   
801058d8:	0f a9                	pop    %gs
801058da:	0f a1                	pop    %fs
801058dc:	07                   	pop    %es
801058dd:	1f                   	pop    %ds
801058de:	83 c4 08             	add    $0x8,%esp
801058e1:	cf                   	iret   
801058e2:	66 90                	xchg   %ax,%ax
801058e4:	66 90                	xchg   %ax,%ax
801058e6:	66 90                	xchg   %ax,%ax
801058e8:	66 90                	xchg   %ax,%ax
801058ea:	66 90                	xchg   %ax,%ax
801058ec:	66 90                	xchg   %ax,%ax
801058ee:	66 90                	xchg   %ax,%ax

801058f0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801058f0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
801058f1:	31 c0                	xor    %eax,%eax
{
801058f3:	89 e5                	mov    %esp,%ebp
801058f5:	83 ec 08             	sub    $0x8,%esp
801058f8:	90                   	nop
801058f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105900:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105907:	c7 04 c5 a2 4d 11 80 	movl   $0x8e000008,-0x7feeb25e(,%eax,8)
8010590e:	08 00 00 8e 
80105912:	66 89 14 c5 a0 4d 11 	mov    %dx,-0x7feeb260(,%eax,8)
80105919:	80 
8010591a:	c1 ea 10             	shr    $0x10,%edx
8010591d:	66 89 14 c5 a6 4d 11 	mov    %dx,-0x7feeb25a(,%eax,8)
80105924:	80 
  for(i = 0; i < 256; i++)
80105925:	83 c0 01             	add    $0x1,%eax
80105928:	3d 00 01 00 00       	cmp    $0x100,%eax
8010592d:	75 d1                	jne    80105900 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010592f:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
80105934:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105937:	c7 05 a2 4f 11 80 08 	movl   $0xef000008,0x80114fa2
8010593e:	00 00 ef 
  initlock(&tickslock, "time");
80105941:	68 65 79 10 80       	push   $0x80107965
80105946:	68 60 4d 11 80       	push   $0x80114d60
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010594b:	66 a3 a0 4f 11 80    	mov    %ax,0x80114fa0
80105951:	c1 e8 10             	shr    $0x10,%eax
80105954:	66 a3 a6 4f 11 80    	mov    %ax,0x80114fa6
  initlock(&tickslock, "time");
8010595a:	e8 41 ea ff ff       	call   801043a0 <initlock>
}
8010595f:	83 c4 10             	add    $0x10,%esp
80105962:	c9                   	leave  
80105963:	c3                   	ret    
80105964:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010596a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105970 <idtinit>:

void
idtinit(void)
{
80105970:	55                   	push   %ebp
  pd[0] = size-1;
80105971:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105976:	89 e5                	mov    %esp,%ebp
80105978:	83 ec 10             	sub    $0x10,%esp
8010597b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010597f:	b8 a0 4d 11 80       	mov    $0x80114da0,%eax
80105984:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105988:	c1 e8 10             	shr    $0x10,%eax
8010598b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010598f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105992:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105995:	c9                   	leave  
80105996:	c3                   	ret    
80105997:	89 f6                	mov    %esi,%esi
80105999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801059a0 <trap>:

void
trap(struct trapframe *tf)
{
801059a0:	55                   	push   %ebp
801059a1:	89 e5                	mov    %esp,%ebp
801059a3:	57                   	push   %edi
801059a4:	56                   	push   %esi
801059a5:	53                   	push   %ebx
801059a6:	83 ec 1c             	sub    $0x1c,%esp
801059a9:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
801059ac:	8b 47 30             	mov    0x30(%edi),%eax
801059af:	83 f8 40             	cmp    $0x40,%eax
801059b2:	0f 84 f0 00 00 00    	je     80105aa8 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801059b8:	83 e8 20             	sub    $0x20,%eax
801059bb:	83 f8 1f             	cmp    $0x1f,%eax
801059be:	77 10                	ja     801059d0 <trap+0x30>
801059c0:	ff 24 85 0c 7a 10 80 	jmp    *-0x7fef85f4(,%eax,4)
801059c7:	89 f6                	mov    %esi,%esi
801059c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
    break;

  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
801059d0:	e8 2b de ff ff       	call   80103800 <myproc>
801059d5:	85 c0                	test   %eax,%eax
801059d7:	8b 5f 38             	mov    0x38(%edi),%ebx
801059da:	0f 84 14 02 00 00    	je     80105bf4 <trap+0x254>
801059e0:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
801059e4:	0f 84 0a 02 00 00    	je     80105bf4 <trap+0x254>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801059ea:	0f 20 d1             	mov    %cr2,%ecx
801059ed:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801059f0:	e8 eb dd ff ff       	call   801037e0 <cpuid>
801059f5:	89 45 dc             	mov    %eax,-0x24(%ebp)
801059f8:	8b 47 34             	mov    0x34(%edi),%eax
801059fb:	8b 77 30             	mov    0x30(%edi),%esi
801059fe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105a01:	e8 fa dd ff ff       	call   80103800 <myproc>
80105a06:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105a09:	e8 f2 dd ff ff       	call   80103800 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a0e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105a11:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105a14:	51                   	push   %ecx
80105a15:	53                   	push   %ebx
80105a16:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80105a17:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a1a:	ff 75 e4             	pushl  -0x1c(%ebp)
80105a1d:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80105a1e:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105a21:	52                   	push   %edx
80105a22:	ff 70 10             	pushl  0x10(%eax)
80105a25:	68 c8 79 10 80       	push   $0x801079c8
80105a2a:	e8 31 ac ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105a2f:	83 c4 20             	add    $0x20,%esp
80105a32:	e8 c9 dd ff ff       	call   80103800 <myproc>
80105a37:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a3e:	e8 bd dd ff ff       	call   80103800 <myproc>
80105a43:	85 c0                	test   %eax,%eax
80105a45:	74 1d                	je     80105a64 <trap+0xc4>
80105a47:	e8 b4 dd ff ff       	call   80103800 <myproc>
80105a4c:	8b 50 24             	mov    0x24(%eax),%edx
80105a4f:	85 d2                	test   %edx,%edx
80105a51:	74 11                	je     80105a64 <trap+0xc4>
80105a53:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105a57:	83 e0 03             	and    $0x3,%eax
80105a5a:	66 83 f8 03          	cmp    $0x3,%ax
80105a5e:	0f 84 4c 01 00 00    	je     80105bb0 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105a64:	e8 97 dd ff ff       	call   80103800 <myproc>
80105a69:	85 c0                	test   %eax,%eax
80105a6b:	74 0b                	je     80105a78 <trap+0xd8>
80105a6d:	e8 8e dd ff ff       	call   80103800 <myproc>
80105a72:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105a76:	74 68                	je     80105ae0 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a78:	e8 83 dd ff ff       	call   80103800 <myproc>
80105a7d:	85 c0                	test   %eax,%eax
80105a7f:	74 19                	je     80105a9a <trap+0xfa>
80105a81:	e8 7a dd ff ff       	call   80103800 <myproc>
80105a86:	8b 40 24             	mov    0x24(%eax),%eax
80105a89:	85 c0                	test   %eax,%eax
80105a8b:	74 0d                	je     80105a9a <trap+0xfa>
80105a8d:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105a91:	83 e0 03             	and    $0x3,%eax
80105a94:	66 83 f8 03          	cmp    $0x3,%ax
80105a98:	74 37                	je     80105ad1 <trap+0x131>
    exit();
}
80105a9a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a9d:	5b                   	pop    %ebx
80105a9e:	5e                   	pop    %esi
80105a9f:	5f                   	pop    %edi
80105aa0:	5d                   	pop    %ebp
80105aa1:	c3                   	ret    
80105aa2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
80105aa8:	e8 53 dd ff ff       	call   80103800 <myproc>
80105aad:	8b 58 24             	mov    0x24(%eax),%ebx
80105ab0:	85 db                	test   %ebx,%ebx
80105ab2:	0f 85 e8 00 00 00    	jne    80105ba0 <trap+0x200>
    myproc()->tf = tf;
80105ab8:	e8 43 dd ff ff       	call   80103800 <myproc>
80105abd:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80105ac0:	e8 5b ef ff ff       	call   80104a20 <syscall>
    if(myproc()->killed)
80105ac5:	e8 36 dd ff ff       	call   80103800 <myproc>
80105aca:	8b 48 24             	mov    0x24(%eax),%ecx
80105acd:	85 c9                	test   %ecx,%ecx
80105acf:	74 c9                	je     80105a9a <trap+0xfa>
}
80105ad1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ad4:	5b                   	pop    %ebx
80105ad5:	5e                   	pop    %esi
80105ad6:	5f                   	pop    %edi
80105ad7:	5d                   	pop    %ebp
      exit();
80105ad8:	e9 63 e1 ff ff       	jmp    80103c40 <exit>
80105add:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80105ae0:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105ae4:	75 92                	jne    80105a78 <trap+0xd8>
    yield();
80105ae6:	e8 85 e2 ff ff       	call   80103d70 <yield>
80105aeb:	eb 8b                	jmp    80105a78 <trap+0xd8>
80105aed:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
80105af0:	e8 eb dc ff ff       	call   801037e0 <cpuid>
80105af5:	85 c0                	test   %eax,%eax
80105af7:	0f 84 c3 00 00 00    	je     80105bc0 <trap+0x220>
    lapiceoi();
80105afd:	e8 5e cc ff ff       	call   80102760 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b02:	e8 f9 dc ff ff       	call   80103800 <myproc>
80105b07:	85 c0                	test   %eax,%eax
80105b09:	0f 85 38 ff ff ff    	jne    80105a47 <trap+0xa7>
80105b0f:	e9 50 ff ff ff       	jmp    80105a64 <trap+0xc4>
80105b14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105b18:	e8 03 cb ff ff       	call   80102620 <kbdintr>
    lapiceoi();
80105b1d:	e8 3e cc ff ff       	call   80102760 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b22:	e8 d9 dc ff ff       	call   80103800 <myproc>
80105b27:	85 c0                	test   %eax,%eax
80105b29:	0f 85 18 ff ff ff    	jne    80105a47 <trap+0xa7>
80105b2f:	e9 30 ff ff ff       	jmp    80105a64 <trap+0xc4>
80105b34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105b38:	e8 53 02 00 00       	call   80105d90 <uartintr>
    lapiceoi();
80105b3d:	e8 1e cc ff ff       	call   80102760 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b42:	e8 b9 dc ff ff       	call   80103800 <myproc>
80105b47:	85 c0                	test   %eax,%eax
80105b49:	0f 85 f8 fe ff ff    	jne    80105a47 <trap+0xa7>
80105b4f:	e9 10 ff ff ff       	jmp    80105a64 <trap+0xc4>
80105b54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105b58:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105b5c:	8b 77 38             	mov    0x38(%edi),%esi
80105b5f:	e8 7c dc ff ff       	call   801037e0 <cpuid>
80105b64:	56                   	push   %esi
80105b65:	53                   	push   %ebx
80105b66:	50                   	push   %eax
80105b67:	68 70 79 10 80       	push   $0x80107970
80105b6c:	e8 ef aa ff ff       	call   80100660 <cprintf>
    lapiceoi();
80105b71:	e8 ea cb ff ff       	call   80102760 <lapiceoi>
    break;
80105b76:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b79:	e8 82 dc ff ff       	call   80103800 <myproc>
80105b7e:	85 c0                	test   %eax,%eax
80105b80:	0f 85 c1 fe ff ff    	jne    80105a47 <trap+0xa7>
80105b86:	e9 d9 fe ff ff       	jmp    80105a64 <trap+0xc4>
80105b8b:	90                   	nop
80105b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80105b90:	e8 fb c4 ff ff       	call   80102090 <ideintr>
80105b95:	e9 63 ff ff ff       	jmp    80105afd <trap+0x15d>
80105b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105ba0:	e8 9b e0 ff ff       	call   80103c40 <exit>
80105ba5:	e9 0e ff ff ff       	jmp    80105ab8 <trap+0x118>
80105baa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
80105bb0:	e8 8b e0 ff ff       	call   80103c40 <exit>
80105bb5:	e9 aa fe ff ff       	jmp    80105a64 <trap+0xc4>
80105bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80105bc0:	83 ec 0c             	sub    $0xc,%esp
80105bc3:	68 60 4d 11 80       	push   $0x80114d60
80105bc8:	e8 c3 e8 ff ff       	call   80104490 <acquire>
      wakeup(&ticks);
80105bcd:	c7 04 24 a0 55 11 80 	movl   $0x801155a0,(%esp)
      ticks++;
80105bd4:	83 05 a0 55 11 80 01 	addl   $0x1,0x801155a0
      wakeup(&ticks);
80105bdb:	e8 90 e3 ff ff       	call   80103f70 <wakeup>
      release(&tickslock);
80105be0:	c7 04 24 60 4d 11 80 	movl   $0x80114d60,(%esp)
80105be7:	e8 c4 e9 ff ff       	call   801045b0 <release>
80105bec:	83 c4 10             	add    $0x10,%esp
80105bef:	e9 09 ff ff ff       	jmp    80105afd <trap+0x15d>
80105bf4:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105bf7:	e8 e4 db ff ff       	call   801037e0 <cpuid>
80105bfc:	83 ec 0c             	sub    $0xc,%esp
80105bff:	56                   	push   %esi
80105c00:	53                   	push   %ebx
80105c01:	50                   	push   %eax
80105c02:	ff 77 30             	pushl  0x30(%edi)
80105c05:	68 94 79 10 80       	push   $0x80107994
80105c0a:	e8 51 aa ff ff       	call   80100660 <cprintf>
      panic("trap");
80105c0f:	83 c4 14             	add    $0x14,%esp
80105c12:	68 6a 79 10 80       	push   $0x8010796a
80105c17:	e8 74 a7 ff ff       	call   80100390 <panic>
80105c1c:	66 90                	xchg   %ax,%ax
80105c1e:	66 90                	xchg   %ax,%ax

80105c20 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105c20:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
{
80105c25:	55                   	push   %ebp
80105c26:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105c28:	85 c0                	test   %eax,%eax
80105c2a:	74 1c                	je     80105c48 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105c2c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105c31:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105c32:	a8 01                	test   $0x1,%al
80105c34:	74 12                	je     80105c48 <uartgetc+0x28>
80105c36:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c3b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105c3c:	0f b6 c0             	movzbl %al,%eax
}
80105c3f:	5d                   	pop    %ebp
80105c40:	c3                   	ret    
80105c41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105c48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105c4d:	5d                   	pop    %ebp
80105c4e:	c3                   	ret    
80105c4f:	90                   	nop

80105c50 <uartputc.part.0>:
uartputc(int c)
80105c50:	55                   	push   %ebp
80105c51:	89 e5                	mov    %esp,%ebp
80105c53:	57                   	push   %edi
80105c54:	56                   	push   %esi
80105c55:	53                   	push   %ebx
80105c56:	89 c7                	mov    %eax,%edi
80105c58:	bb 80 00 00 00       	mov    $0x80,%ebx
80105c5d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105c62:	83 ec 0c             	sub    $0xc,%esp
80105c65:	eb 1b                	jmp    80105c82 <uartputc.part.0+0x32>
80105c67:	89 f6                	mov    %esi,%esi
80105c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80105c70:	83 ec 0c             	sub    $0xc,%esp
80105c73:	6a 0a                	push   $0xa
80105c75:	e8 06 cb ff ff       	call   80102780 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105c7a:	83 c4 10             	add    $0x10,%esp
80105c7d:	83 eb 01             	sub    $0x1,%ebx
80105c80:	74 07                	je     80105c89 <uartputc.part.0+0x39>
80105c82:	89 f2                	mov    %esi,%edx
80105c84:	ec                   	in     (%dx),%al
80105c85:	a8 20                	test   $0x20,%al
80105c87:	74 e7                	je     80105c70 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105c89:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c8e:	89 f8                	mov    %edi,%eax
80105c90:	ee                   	out    %al,(%dx)
}
80105c91:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c94:	5b                   	pop    %ebx
80105c95:	5e                   	pop    %esi
80105c96:	5f                   	pop    %edi
80105c97:	5d                   	pop    %ebp
80105c98:	c3                   	ret    
80105c99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105ca0 <uartinit>:
{
80105ca0:	55                   	push   %ebp
80105ca1:	31 c9                	xor    %ecx,%ecx
80105ca3:	89 c8                	mov    %ecx,%eax
80105ca5:	89 e5                	mov    %esp,%ebp
80105ca7:	57                   	push   %edi
80105ca8:	56                   	push   %esi
80105ca9:	53                   	push   %ebx
80105caa:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105caf:	89 da                	mov    %ebx,%edx
80105cb1:	83 ec 0c             	sub    $0xc,%esp
80105cb4:	ee                   	out    %al,(%dx)
80105cb5:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105cba:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105cbf:	89 fa                	mov    %edi,%edx
80105cc1:	ee                   	out    %al,(%dx)
80105cc2:	b8 0c 00 00 00       	mov    $0xc,%eax
80105cc7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105ccc:	ee                   	out    %al,(%dx)
80105ccd:	be f9 03 00 00       	mov    $0x3f9,%esi
80105cd2:	89 c8                	mov    %ecx,%eax
80105cd4:	89 f2                	mov    %esi,%edx
80105cd6:	ee                   	out    %al,(%dx)
80105cd7:	b8 03 00 00 00       	mov    $0x3,%eax
80105cdc:	89 fa                	mov    %edi,%edx
80105cde:	ee                   	out    %al,(%dx)
80105cdf:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105ce4:	89 c8                	mov    %ecx,%eax
80105ce6:	ee                   	out    %al,(%dx)
80105ce7:	b8 01 00 00 00       	mov    $0x1,%eax
80105cec:	89 f2                	mov    %esi,%edx
80105cee:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105cef:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105cf4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105cf5:	3c ff                	cmp    $0xff,%al
80105cf7:	74 5a                	je     80105d53 <uartinit+0xb3>
  uart = 1;
80105cf9:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
80105d00:	00 00 00 
80105d03:	89 da                	mov    %ebx,%edx
80105d05:	ec                   	in     (%dx),%al
80105d06:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d0b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105d0c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80105d0f:	bb 8c 7a 10 80       	mov    $0x80107a8c,%ebx
  ioapicenable(IRQ_COM1, 0);
80105d14:	6a 00                	push   $0x0
80105d16:	6a 04                	push   $0x4
80105d18:	e8 c3 c5 ff ff       	call   801022e0 <ioapicenable>
80105d1d:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105d20:	b8 78 00 00 00       	mov    $0x78,%eax
80105d25:	eb 13                	jmp    80105d3a <uartinit+0x9a>
80105d27:	89 f6                	mov    %esi,%esi
80105d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105d30:	83 c3 01             	add    $0x1,%ebx
80105d33:	0f be 03             	movsbl (%ebx),%eax
80105d36:	84 c0                	test   %al,%al
80105d38:	74 19                	je     80105d53 <uartinit+0xb3>
  if(!uart)
80105d3a:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80105d40:	85 d2                	test   %edx,%edx
80105d42:	74 ec                	je     80105d30 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80105d44:	83 c3 01             	add    $0x1,%ebx
80105d47:	e8 04 ff ff ff       	call   80105c50 <uartputc.part.0>
80105d4c:	0f be 03             	movsbl (%ebx),%eax
80105d4f:	84 c0                	test   %al,%al
80105d51:	75 e7                	jne    80105d3a <uartinit+0x9a>
}
80105d53:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d56:	5b                   	pop    %ebx
80105d57:	5e                   	pop    %esi
80105d58:	5f                   	pop    %edi
80105d59:	5d                   	pop    %ebp
80105d5a:	c3                   	ret    
80105d5b:	90                   	nop
80105d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105d60 <uartputc>:
  if(!uart)
80105d60:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
{
80105d66:	55                   	push   %ebp
80105d67:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105d69:	85 d2                	test   %edx,%edx
{
80105d6b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80105d6e:	74 10                	je     80105d80 <uartputc+0x20>
}
80105d70:	5d                   	pop    %ebp
80105d71:	e9 da fe ff ff       	jmp    80105c50 <uartputc.part.0>
80105d76:	8d 76 00             	lea    0x0(%esi),%esi
80105d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105d80:	5d                   	pop    %ebp
80105d81:	c3                   	ret    
80105d82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105d90 <uartintr>:

void
uartintr(void)
{
80105d90:	55                   	push   %ebp
80105d91:	89 e5                	mov    %esp,%ebp
80105d93:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105d96:	68 20 5c 10 80       	push   $0x80105c20
80105d9b:	e8 70 aa ff ff       	call   80100810 <consoleintr>
}
80105da0:	83 c4 10             	add    $0x10,%esp
80105da3:	c9                   	leave  
80105da4:	c3                   	ret    

80105da5 <vector0>:
80105da5:	6a 00                	push   $0x0
80105da7:	6a 00                	push   $0x0
80105da9:	e9 11 fb ff ff       	jmp    801058bf <alltraps>

80105dae <vector1>:
80105dae:	6a 00                	push   $0x0
80105db0:	6a 01                	push   $0x1
80105db2:	e9 08 fb ff ff       	jmp    801058bf <alltraps>

80105db7 <vector2>:
80105db7:	6a 00                	push   $0x0
80105db9:	6a 02                	push   $0x2
80105dbb:	e9 ff fa ff ff       	jmp    801058bf <alltraps>

80105dc0 <vector3>:
80105dc0:	6a 00                	push   $0x0
80105dc2:	6a 03                	push   $0x3
80105dc4:	e9 f6 fa ff ff       	jmp    801058bf <alltraps>

80105dc9 <vector4>:
80105dc9:	6a 00                	push   $0x0
80105dcb:	6a 04                	push   $0x4
80105dcd:	e9 ed fa ff ff       	jmp    801058bf <alltraps>

80105dd2 <vector5>:
80105dd2:	6a 00                	push   $0x0
80105dd4:	6a 05                	push   $0x5
80105dd6:	e9 e4 fa ff ff       	jmp    801058bf <alltraps>

80105ddb <vector6>:
80105ddb:	6a 00                	push   $0x0
80105ddd:	6a 06                	push   $0x6
80105ddf:	e9 db fa ff ff       	jmp    801058bf <alltraps>

80105de4 <vector7>:
80105de4:	6a 00                	push   $0x0
80105de6:	6a 07                	push   $0x7
80105de8:	e9 d2 fa ff ff       	jmp    801058bf <alltraps>

80105ded <vector8>:
80105ded:	6a 08                	push   $0x8
80105def:	e9 cb fa ff ff       	jmp    801058bf <alltraps>

80105df4 <vector9>:
80105df4:	6a 00                	push   $0x0
80105df6:	6a 09                	push   $0x9
80105df8:	e9 c2 fa ff ff       	jmp    801058bf <alltraps>

80105dfd <vector10>:
80105dfd:	6a 0a                	push   $0xa
80105dff:	e9 bb fa ff ff       	jmp    801058bf <alltraps>

80105e04 <vector11>:
80105e04:	6a 0b                	push   $0xb
80105e06:	e9 b4 fa ff ff       	jmp    801058bf <alltraps>

80105e0b <vector12>:
80105e0b:	6a 0c                	push   $0xc
80105e0d:	e9 ad fa ff ff       	jmp    801058bf <alltraps>

80105e12 <vector13>:
80105e12:	6a 0d                	push   $0xd
80105e14:	e9 a6 fa ff ff       	jmp    801058bf <alltraps>

80105e19 <vector14>:
80105e19:	6a 0e                	push   $0xe
80105e1b:	e9 9f fa ff ff       	jmp    801058bf <alltraps>

80105e20 <vector15>:
80105e20:	6a 00                	push   $0x0
80105e22:	6a 0f                	push   $0xf
80105e24:	e9 96 fa ff ff       	jmp    801058bf <alltraps>

80105e29 <vector16>:
80105e29:	6a 00                	push   $0x0
80105e2b:	6a 10                	push   $0x10
80105e2d:	e9 8d fa ff ff       	jmp    801058bf <alltraps>

80105e32 <vector17>:
80105e32:	6a 11                	push   $0x11
80105e34:	e9 86 fa ff ff       	jmp    801058bf <alltraps>

80105e39 <vector18>:
80105e39:	6a 00                	push   $0x0
80105e3b:	6a 12                	push   $0x12
80105e3d:	e9 7d fa ff ff       	jmp    801058bf <alltraps>

80105e42 <vector19>:
80105e42:	6a 00                	push   $0x0
80105e44:	6a 13                	push   $0x13
80105e46:	e9 74 fa ff ff       	jmp    801058bf <alltraps>

80105e4b <vector20>:
80105e4b:	6a 00                	push   $0x0
80105e4d:	6a 14                	push   $0x14
80105e4f:	e9 6b fa ff ff       	jmp    801058bf <alltraps>

80105e54 <vector21>:
80105e54:	6a 00                	push   $0x0
80105e56:	6a 15                	push   $0x15
80105e58:	e9 62 fa ff ff       	jmp    801058bf <alltraps>

80105e5d <vector22>:
80105e5d:	6a 00                	push   $0x0
80105e5f:	6a 16                	push   $0x16
80105e61:	e9 59 fa ff ff       	jmp    801058bf <alltraps>

80105e66 <vector23>:
80105e66:	6a 00                	push   $0x0
80105e68:	6a 17                	push   $0x17
80105e6a:	e9 50 fa ff ff       	jmp    801058bf <alltraps>

80105e6f <vector24>:
80105e6f:	6a 00                	push   $0x0
80105e71:	6a 18                	push   $0x18
80105e73:	e9 47 fa ff ff       	jmp    801058bf <alltraps>

80105e78 <vector25>:
80105e78:	6a 00                	push   $0x0
80105e7a:	6a 19                	push   $0x19
80105e7c:	e9 3e fa ff ff       	jmp    801058bf <alltraps>

80105e81 <vector26>:
80105e81:	6a 00                	push   $0x0
80105e83:	6a 1a                	push   $0x1a
80105e85:	e9 35 fa ff ff       	jmp    801058bf <alltraps>

80105e8a <vector27>:
80105e8a:	6a 00                	push   $0x0
80105e8c:	6a 1b                	push   $0x1b
80105e8e:	e9 2c fa ff ff       	jmp    801058bf <alltraps>

80105e93 <vector28>:
80105e93:	6a 00                	push   $0x0
80105e95:	6a 1c                	push   $0x1c
80105e97:	e9 23 fa ff ff       	jmp    801058bf <alltraps>

80105e9c <vector29>:
80105e9c:	6a 00                	push   $0x0
80105e9e:	6a 1d                	push   $0x1d
80105ea0:	e9 1a fa ff ff       	jmp    801058bf <alltraps>

80105ea5 <vector30>:
80105ea5:	6a 00                	push   $0x0
80105ea7:	6a 1e                	push   $0x1e
80105ea9:	e9 11 fa ff ff       	jmp    801058bf <alltraps>

80105eae <vector31>:
80105eae:	6a 00                	push   $0x0
80105eb0:	6a 1f                	push   $0x1f
80105eb2:	e9 08 fa ff ff       	jmp    801058bf <alltraps>

80105eb7 <vector32>:
80105eb7:	6a 00                	push   $0x0
80105eb9:	6a 20                	push   $0x20
80105ebb:	e9 ff f9 ff ff       	jmp    801058bf <alltraps>

80105ec0 <vector33>:
80105ec0:	6a 00                	push   $0x0
80105ec2:	6a 21                	push   $0x21
80105ec4:	e9 f6 f9 ff ff       	jmp    801058bf <alltraps>

80105ec9 <vector34>:
80105ec9:	6a 00                	push   $0x0
80105ecb:	6a 22                	push   $0x22
80105ecd:	e9 ed f9 ff ff       	jmp    801058bf <alltraps>

80105ed2 <vector35>:
80105ed2:	6a 00                	push   $0x0
80105ed4:	6a 23                	push   $0x23
80105ed6:	e9 e4 f9 ff ff       	jmp    801058bf <alltraps>

80105edb <vector36>:
80105edb:	6a 00                	push   $0x0
80105edd:	6a 24                	push   $0x24
80105edf:	e9 db f9 ff ff       	jmp    801058bf <alltraps>

80105ee4 <vector37>:
80105ee4:	6a 00                	push   $0x0
80105ee6:	6a 25                	push   $0x25
80105ee8:	e9 d2 f9 ff ff       	jmp    801058bf <alltraps>

80105eed <vector38>:
80105eed:	6a 00                	push   $0x0
80105eef:	6a 26                	push   $0x26
80105ef1:	e9 c9 f9 ff ff       	jmp    801058bf <alltraps>

80105ef6 <vector39>:
80105ef6:	6a 00                	push   $0x0
80105ef8:	6a 27                	push   $0x27
80105efa:	e9 c0 f9 ff ff       	jmp    801058bf <alltraps>

80105eff <vector40>:
80105eff:	6a 00                	push   $0x0
80105f01:	6a 28                	push   $0x28
80105f03:	e9 b7 f9 ff ff       	jmp    801058bf <alltraps>

80105f08 <vector41>:
80105f08:	6a 00                	push   $0x0
80105f0a:	6a 29                	push   $0x29
80105f0c:	e9 ae f9 ff ff       	jmp    801058bf <alltraps>

80105f11 <vector42>:
80105f11:	6a 00                	push   $0x0
80105f13:	6a 2a                	push   $0x2a
80105f15:	e9 a5 f9 ff ff       	jmp    801058bf <alltraps>

80105f1a <vector43>:
80105f1a:	6a 00                	push   $0x0
80105f1c:	6a 2b                	push   $0x2b
80105f1e:	e9 9c f9 ff ff       	jmp    801058bf <alltraps>

80105f23 <vector44>:
80105f23:	6a 00                	push   $0x0
80105f25:	6a 2c                	push   $0x2c
80105f27:	e9 93 f9 ff ff       	jmp    801058bf <alltraps>

80105f2c <vector45>:
80105f2c:	6a 00                	push   $0x0
80105f2e:	6a 2d                	push   $0x2d
80105f30:	e9 8a f9 ff ff       	jmp    801058bf <alltraps>

80105f35 <vector46>:
80105f35:	6a 00                	push   $0x0
80105f37:	6a 2e                	push   $0x2e
80105f39:	e9 81 f9 ff ff       	jmp    801058bf <alltraps>

80105f3e <vector47>:
80105f3e:	6a 00                	push   $0x0
80105f40:	6a 2f                	push   $0x2f
80105f42:	e9 78 f9 ff ff       	jmp    801058bf <alltraps>

80105f47 <vector48>:
80105f47:	6a 00                	push   $0x0
80105f49:	6a 30                	push   $0x30
80105f4b:	e9 6f f9 ff ff       	jmp    801058bf <alltraps>

80105f50 <vector49>:
80105f50:	6a 00                	push   $0x0
80105f52:	6a 31                	push   $0x31
80105f54:	e9 66 f9 ff ff       	jmp    801058bf <alltraps>

80105f59 <vector50>:
80105f59:	6a 00                	push   $0x0
80105f5b:	6a 32                	push   $0x32
80105f5d:	e9 5d f9 ff ff       	jmp    801058bf <alltraps>

80105f62 <vector51>:
80105f62:	6a 00                	push   $0x0
80105f64:	6a 33                	push   $0x33
80105f66:	e9 54 f9 ff ff       	jmp    801058bf <alltraps>

80105f6b <vector52>:
80105f6b:	6a 00                	push   $0x0
80105f6d:	6a 34                	push   $0x34
80105f6f:	e9 4b f9 ff ff       	jmp    801058bf <alltraps>

80105f74 <vector53>:
80105f74:	6a 00                	push   $0x0
80105f76:	6a 35                	push   $0x35
80105f78:	e9 42 f9 ff ff       	jmp    801058bf <alltraps>

80105f7d <vector54>:
80105f7d:	6a 00                	push   $0x0
80105f7f:	6a 36                	push   $0x36
80105f81:	e9 39 f9 ff ff       	jmp    801058bf <alltraps>

80105f86 <vector55>:
80105f86:	6a 00                	push   $0x0
80105f88:	6a 37                	push   $0x37
80105f8a:	e9 30 f9 ff ff       	jmp    801058bf <alltraps>

80105f8f <vector56>:
80105f8f:	6a 00                	push   $0x0
80105f91:	6a 38                	push   $0x38
80105f93:	e9 27 f9 ff ff       	jmp    801058bf <alltraps>

80105f98 <vector57>:
80105f98:	6a 00                	push   $0x0
80105f9a:	6a 39                	push   $0x39
80105f9c:	e9 1e f9 ff ff       	jmp    801058bf <alltraps>

80105fa1 <vector58>:
80105fa1:	6a 00                	push   $0x0
80105fa3:	6a 3a                	push   $0x3a
80105fa5:	e9 15 f9 ff ff       	jmp    801058bf <alltraps>

80105faa <vector59>:
80105faa:	6a 00                	push   $0x0
80105fac:	6a 3b                	push   $0x3b
80105fae:	e9 0c f9 ff ff       	jmp    801058bf <alltraps>

80105fb3 <vector60>:
80105fb3:	6a 00                	push   $0x0
80105fb5:	6a 3c                	push   $0x3c
80105fb7:	e9 03 f9 ff ff       	jmp    801058bf <alltraps>

80105fbc <vector61>:
80105fbc:	6a 00                	push   $0x0
80105fbe:	6a 3d                	push   $0x3d
80105fc0:	e9 fa f8 ff ff       	jmp    801058bf <alltraps>

80105fc5 <vector62>:
80105fc5:	6a 00                	push   $0x0
80105fc7:	6a 3e                	push   $0x3e
80105fc9:	e9 f1 f8 ff ff       	jmp    801058bf <alltraps>

80105fce <vector63>:
80105fce:	6a 00                	push   $0x0
80105fd0:	6a 3f                	push   $0x3f
80105fd2:	e9 e8 f8 ff ff       	jmp    801058bf <alltraps>

80105fd7 <vector64>:
80105fd7:	6a 00                	push   $0x0
80105fd9:	6a 40                	push   $0x40
80105fdb:	e9 df f8 ff ff       	jmp    801058bf <alltraps>

80105fe0 <vector65>:
80105fe0:	6a 00                	push   $0x0
80105fe2:	6a 41                	push   $0x41
80105fe4:	e9 d6 f8 ff ff       	jmp    801058bf <alltraps>

80105fe9 <vector66>:
80105fe9:	6a 00                	push   $0x0
80105feb:	6a 42                	push   $0x42
80105fed:	e9 cd f8 ff ff       	jmp    801058bf <alltraps>

80105ff2 <vector67>:
80105ff2:	6a 00                	push   $0x0
80105ff4:	6a 43                	push   $0x43
80105ff6:	e9 c4 f8 ff ff       	jmp    801058bf <alltraps>

80105ffb <vector68>:
80105ffb:	6a 00                	push   $0x0
80105ffd:	6a 44                	push   $0x44
80105fff:	e9 bb f8 ff ff       	jmp    801058bf <alltraps>

80106004 <vector69>:
80106004:	6a 00                	push   $0x0
80106006:	6a 45                	push   $0x45
80106008:	e9 b2 f8 ff ff       	jmp    801058bf <alltraps>

8010600d <vector70>:
8010600d:	6a 00                	push   $0x0
8010600f:	6a 46                	push   $0x46
80106011:	e9 a9 f8 ff ff       	jmp    801058bf <alltraps>

80106016 <vector71>:
80106016:	6a 00                	push   $0x0
80106018:	6a 47                	push   $0x47
8010601a:	e9 a0 f8 ff ff       	jmp    801058bf <alltraps>

8010601f <vector72>:
8010601f:	6a 00                	push   $0x0
80106021:	6a 48                	push   $0x48
80106023:	e9 97 f8 ff ff       	jmp    801058bf <alltraps>

80106028 <vector73>:
80106028:	6a 00                	push   $0x0
8010602a:	6a 49                	push   $0x49
8010602c:	e9 8e f8 ff ff       	jmp    801058bf <alltraps>

80106031 <vector74>:
80106031:	6a 00                	push   $0x0
80106033:	6a 4a                	push   $0x4a
80106035:	e9 85 f8 ff ff       	jmp    801058bf <alltraps>

8010603a <vector75>:
8010603a:	6a 00                	push   $0x0
8010603c:	6a 4b                	push   $0x4b
8010603e:	e9 7c f8 ff ff       	jmp    801058bf <alltraps>

80106043 <vector76>:
80106043:	6a 00                	push   $0x0
80106045:	6a 4c                	push   $0x4c
80106047:	e9 73 f8 ff ff       	jmp    801058bf <alltraps>

8010604c <vector77>:
8010604c:	6a 00                	push   $0x0
8010604e:	6a 4d                	push   $0x4d
80106050:	e9 6a f8 ff ff       	jmp    801058bf <alltraps>

80106055 <vector78>:
80106055:	6a 00                	push   $0x0
80106057:	6a 4e                	push   $0x4e
80106059:	e9 61 f8 ff ff       	jmp    801058bf <alltraps>

8010605e <vector79>:
8010605e:	6a 00                	push   $0x0
80106060:	6a 4f                	push   $0x4f
80106062:	e9 58 f8 ff ff       	jmp    801058bf <alltraps>

80106067 <vector80>:
80106067:	6a 00                	push   $0x0
80106069:	6a 50                	push   $0x50
8010606b:	e9 4f f8 ff ff       	jmp    801058bf <alltraps>

80106070 <vector81>:
80106070:	6a 00                	push   $0x0
80106072:	6a 51                	push   $0x51
80106074:	e9 46 f8 ff ff       	jmp    801058bf <alltraps>

80106079 <vector82>:
80106079:	6a 00                	push   $0x0
8010607b:	6a 52                	push   $0x52
8010607d:	e9 3d f8 ff ff       	jmp    801058bf <alltraps>

80106082 <vector83>:
80106082:	6a 00                	push   $0x0
80106084:	6a 53                	push   $0x53
80106086:	e9 34 f8 ff ff       	jmp    801058bf <alltraps>

8010608b <vector84>:
8010608b:	6a 00                	push   $0x0
8010608d:	6a 54                	push   $0x54
8010608f:	e9 2b f8 ff ff       	jmp    801058bf <alltraps>

80106094 <vector85>:
80106094:	6a 00                	push   $0x0
80106096:	6a 55                	push   $0x55
80106098:	e9 22 f8 ff ff       	jmp    801058bf <alltraps>

8010609d <vector86>:
8010609d:	6a 00                	push   $0x0
8010609f:	6a 56                	push   $0x56
801060a1:	e9 19 f8 ff ff       	jmp    801058bf <alltraps>

801060a6 <vector87>:
801060a6:	6a 00                	push   $0x0
801060a8:	6a 57                	push   $0x57
801060aa:	e9 10 f8 ff ff       	jmp    801058bf <alltraps>

801060af <vector88>:
801060af:	6a 00                	push   $0x0
801060b1:	6a 58                	push   $0x58
801060b3:	e9 07 f8 ff ff       	jmp    801058bf <alltraps>

801060b8 <vector89>:
801060b8:	6a 00                	push   $0x0
801060ba:	6a 59                	push   $0x59
801060bc:	e9 fe f7 ff ff       	jmp    801058bf <alltraps>

801060c1 <vector90>:
801060c1:	6a 00                	push   $0x0
801060c3:	6a 5a                	push   $0x5a
801060c5:	e9 f5 f7 ff ff       	jmp    801058bf <alltraps>

801060ca <vector91>:
801060ca:	6a 00                	push   $0x0
801060cc:	6a 5b                	push   $0x5b
801060ce:	e9 ec f7 ff ff       	jmp    801058bf <alltraps>

801060d3 <vector92>:
801060d3:	6a 00                	push   $0x0
801060d5:	6a 5c                	push   $0x5c
801060d7:	e9 e3 f7 ff ff       	jmp    801058bf <alltraps>

801060dc <vector93>:
801060dc:	6a 00                	push   $0x0
801060de:	6a 5d                	push   $0x5d
801060e0:	e9 da f7 ff ff       	jmp    801058bf <alltraps>

801060e5 <vector94>:
801060e5:	6a 00                	push   $0x0
801060e7:	6a 5e                	push   $0x5e
801060e9:	e9 d1 f7 ff ff       	jmp    801058bf <alltraps>

801060ee <vector95>:
801060ee:	6a 00                	push   $0x0
801060f0:	6a 5f                	push   $0x5f
801060f2:	e9 c8 f7 ff ff       	jmp    801058bf <alltraps>

801060f7 <vector96>:
801060f7:	6a 00                	push   $0x0
801060f9:	6a 60                	push   $0x60
801060fb:	e9 bf f7 ff ff       	jmp    801058bf <alltraps>

80106100 <vector97>:
80106100:	6a 00                	push   $0x0
80106102:	6a 61                	push   $0x61
80106104:	e9 b6 f7 ff ff       	jmp    801058bf <alltraps>

80106109 <vector98>:
80106109:	6a 00                	push   $0x0
8010610b:	6a 62                	push   $0x62
8010610d:	e9 ad f7 ff ff       	jmp    801058bf <alltraps>

80106112 <vector99>:
80106112:	6a 00                	push   $0x0
80106114:	6a 63                	push   $0x63
80106116:	e9 a4 f7 ff ff       	jmp    801058bf <alltraps>

8010611b <vector100>:
8010611b:	6a 00                	push   $0x0
8010611d:	6a 64                	push   $0x64
8010611f:	e9 9b f7 ff ff       	jmp    801058bf <alltraps>

80106124 <vector101>:
80106124:	6a 00                	push   $0x0
80106126:	6a 65                	push   $0x65
80106128:	e9 92 f7 ff ff       	jmp    801058bf <alltraps>

8010612d <vector102>:
8010612d:	6a 00                	push   $0x0
8010612f:	6a 66                	push   $0x66
80106131:	e9 89 f7 ff ff       	jmp    801058bf <alltraps>

80106136 <vector103>:
80106136:	6a 00                	push   $0x0
80106138:	6a 67                	push   $0x67
8010613a:	e9 80 f7 ff ff       	jmp    801058bf <alltraps>

8010613f <vector104>:
8010613f:	6a 00                	push   $0x0
80106141:	6a 68                	push   $0x68
80106143:	e9 77 f7 ff ff       	jmp    801058bf <alltraps>

80106148 <vector105>:
80106148:	6a 00                	push   $0x0
8010614a:	6a 69                	push   $0x69
8010614c:	e9 6e f7 ff ff       	jmp    801058bf <alltraps>

80106151 <vector106>:
80106151:	6a 00                	push   $0x0
80106153:	6a 6a                	push   $0x6a
80106155:	e9 65 f7 ff ff       	jmp    801058bf <alltraps>

8010615a <vector107>:
8010615a:	6a 00                	push   $0x0
8010615c:	6a 6b                	push   $0x6b
8010615e:	e9 5c f7 ff ff       	jmp    801058bf <alltraps>

80106163 <vector108>:
80106163:	6a 00                	push   $0x0
80106165:	6a 6c                	push   $0x6c
80106167:	e9 53 f7 ff ff       	jmp    801058bf <alltraps>

8010616c <vector109>:
8010616c:	6a 00                	push   $0x0
8010616e:	6a 6d                	push   $0x6d
80106170:	e9 4a f7 ff ff       	jmp    801058bf <alltraps>

80106175 <vector110>:
80106175:	6a 00                	push   $0x0
80106177:	6a 6e                	push   $0x6e
80106179:	e9 41 f7 ff ff       	jmp    801058bf <alltraps>

8010617e <vector111>:
8010617e:	6a 00                	push   $0x0
80106180:	6a 6f                	push   $0x6f
80106182:	e9 38 f7 ff ff       	jmp    801058bf <alltraps>

80106187 <vector112>:
80106187:	6a 00                	push   $0x0
80106189:	6a 70                	push   $0x70
8010618b:	e9 2f f7 ff ff       	jmp    801058bf <alltraps>

80106190 <vector113>:
80106190:	6a 00                	push   $0x0
80106192:	6a 71                	push   $0x71
80106194:	e9 26 f7 ff ff       	jmp    801058bf <alltraps>

80106199 <vector114>:
80106199:	6a 00                	push   $0x0
8010619b:	6a 72                	push   $0x72
8010619d:	e9 1d f7 ff ff       	jmp    801058bf <alltraps>

801061a2 <vector115>:
801061a2:	6a 00                	push   $0x0
801061a4:	6a 73                	push   $0x73
801061a6:	e9 14 f7 ff ff       	jmp    801058bf <alltraps>

801061ab <vector116>:
801061ab:	6a 00                	push   $0x0
801061ad:	6a 74                	push   $0x74
801061af:	e9 0b f7 ff ff       	jmp    801058bf <alltraps>

801061b4 <vector117>:
801061b4:	6a 00                	push   $0x0
801061b6:	6a 75                	push   $0x75
801061b8:	e9 02 f7 ff ff       	jmp    801058bf <alltraps>

801061bd <vector118>:
801061bd:	6a 00                	push   $0x0
801061bf:	6a 76                	push   $0x76
801061c1:	e9 f9 f6 ff ff       	jmp    801058bf <alltraps>

801061c6 <vector119>:
801061c6:	6a 00                	push   $0x0
801061c8:	6a 77                	push   $0x77
801061ca:	e9 f0 f6 ff ff       	jmp    801058bf <alltraps>

801061cf <vector120>:
801061cf:	6a 00                	push   $0x0
801061d1:	6a 78                	push   $0x78
801061d3:	e9 e7 f6 ff ff       	jmp    801058bf <alltraps>

801061d8 <vector121>:
801061d8:	6a 00                	push   $0x0
801061da:	6a 79                	push   $0x79
801061dc:	e9 de f6 ff ff       	jmp    801058bf <alltraps>

801061e1 <vector122>:
801061e1:	6a 00                	push   $0x0
801061e3:	6a 7a                	push   $0x7a
801061e5:	e9 d5 f6 ff ff       	jmp    801058bf <alltraps>

801061ea <vector123>:
801061ea:	6a 00                	push   $0x0
801061ec:	6a 7b                	push   $0x7b
801061ee:	e9 cc f6 ff ff       	jmp    801058bf <alltraps>

801061f3 <vector124>:
801061f3:	6a 00                	push   $0x0
801061f5:	6a 7c                	push   $0x7c
801061f7:	e9 c3 f6 ff ff       	jmp    801058bf <alltraps>

801061fc <vector125>:
801061fc:	6a 00                	push   $0x0
801061fe:	6a 7d                	push   $0x7d
80106200:	e9 ba f6 ff ff       	jmp    801058bf <alltraps>

80106205 <vector126>:
80106205:	6a 00                	push   $0x0
80106207:	6a 7e                	push   $0x7e
80106209:	e9 b1 f6 ff ff       	jmp    801058bf <alltraps>

8010620e <vector127>:
8010620e:	6a 00                	push   $0x0
80106210:	6a 7f                	push   $0x7f
80106212:	e9 a8 f6 ff ff       	jmp    801058bf <alltraps>

80106217 <vector128>:
80106217:	6a 00                	push   $0x0
80106219:	68 80 00 00 00       	push   $0x80
8010621e:	e9 9c f6 ff ff       	jmp    801058bf <alltraps>

80106223 <vector129>:
80106223:	6a 00                	push   $0x0
80106225:	68 81 00 00 00       	push   $0x81
8010622a:	e9 90 f6 ff ff       	jmp    801058bf <alltraps>

8010622f <vector130>:
8010622f:	6a 00                	push   $0x0
80106231:	68 82 00 00 00       	push   $0x82
80106236:	e9 84 f6 ff ff       	jmp    801058bf <alltraps>

8010623b <vector131>:
8010623b:	6a 00                	push   $0x0
8010623d:	68 83 00 00 00       	push   $0x83
80106242:	e9 78 f6 ff ff       	jmp    801058bf <alltraps>

80106247 <vector132>:
80106247:	6a 00                	push   $0x0
80106249:	68 84 00 00 00       	push   $0x84
8010624e:	e9 6c f6 ff ff       	jmp    801058bf <alltraps>

80106253 <vector133>:
80106253:	6a 00                	push   $0x0
80106255:	68 85 00 00 00       	push   $0x85
8010625a:	e9 60 f6 ff ff       	jmp    801058bf <alltraps>

8010625f <vector134>:
8010625f:	6a 00                	push   $0x0
80106261:	68 86 00 00 00       	push   $0x86
80106266:	e9 54 f6 ff ff       	jmp    801058bf <alltraps>

8010626b <vector135>:
8010626b:	6a 00                	push   $0x0
8010626d:	68 87 00 00 00       	push   $0x87
80106272:	e9 48 f6 ff ff       	jmp    801058bf <alltraps>

80106277 <vector136>:
80106277:	6a 00                	push   $0x0
80106279:	68 88 00 00 00       	push   $0x88
8010627e:	e9 3c f6 ff ff       	jmp    801058bf <alltraps>

80106283 <vector137>:
80106283:	6a 00                	push   $0x0
80106285:	68 89 00 00 00       	push   $0x89
8010628a:	e9 30 f6 ff ff       	jmp    801058bf <alltraps>

8010628f <vector138>:
8010628f:	6a 00                	push   $0x0
80106291:	68 8a 00 00 00       	push   $0x8a
80106296:	e9 24 f6 ff ff       	jmp    801058bf <alltraps>

8010629b <vector139>:
8010629b:	6a 00                	push   $0x0
8010629d:	68 8b 00 00 00       	push   $0x8b
801062a2:	e9 18 f6 ff ff       	jmp    801058bf <alltraps>

801062a7 <vector140>:
801062a7:	6a 00                	push   $0x0
801062a9:	68 8c 00 00 00       	push   $0x8c
801062ae:	e9 0c f6 ff ff       	jmp    801058bf <alltraps>

801062b3 <vector141>:
801062b3:	6a 00                	push   $0x0
801062b5:	68 8d 00 00 00       	push   $0x8d
801062ba:	e9 00 f6 ff ff       	jmp    801058bf <alltraps>

801062bf <vector142>:
801062bf:	6a 00                	push   $0x0
801062c1:	68 8e 00 00 00       	push   $0x8e
801062c6:	e9 f4 f5 ff ff       	jmp    801058bf <alltraps>

801062cb <vector143>:
801062cb:	6a 00                	push   $0x0
801062cd:	68 8f 00 00 00       	push   $0x8f
801062d2:	e9 e8 f5 ff ff       	jmp    801058bf <alltraps>

801062d7 <vector144>:
801062d7:	6a 00                	push   $0x0
801062d9:	68 90 00 00 00       	push   $0x90
801062de:	e9 dc f5 ff ff       	jmp    801058bf <alltraps>

801062e3 <vector145>:
801062e3:	6a 00                	push   $0x0
801062e5:	68 91 00 00 00       	push   $0x91
801062ea:	e9 d0 f5 ff ff       	jmp    801058bf <alltraps>

801062ef <vector146>:
801062ef:	6a 00                	push   $0x0
801062f1:	68 92 00 00 00       	push   $0x92
801062f6:	e9 c4 f5 ff ff       	jmp    801058bf <alltraps>

801062fb <vector147>:
801062fb:	6a 00                	push   $0x0
801062fd:	68 93 00 00 00       	push   $0x93
80106302:	e9 b8 f5 ff ff       	jmp    801058bf <alltraps>

80106307 <vector148>:
80106307:	6a 00                	push   $0x0
80106309:	68 94 00 00 00       	push   $0x94
8010630e:	e9 ac f5 ff ff       	jmp    801058bf <alltraps>

80106313 <vector149>:
80106313:	6a 00                	push   $0x0
80106315:	68 95 00 00 00       	push   $0x95
8010631a:	e9 a0 f5 ff ff       	jmp    801058bf <alltraps>

8010631f <vector150>:
8010631f:	6a 00                	push   $0x0
80106321:	68 96 00 00 00       	push   $0x96
80106326:	e9 94 f5 ff ff       	jmp    801058bf <alltraps>

8010632b <vector151>:
8010632b:	6a 00                	push   $0x0
8010632d:	68 97 00 00 00       	push   $0x97
80106332:	e9 88 f5 ff ff       	jmp    801058bf <alltraps>

80106337 <vector152>:
80106337:	6a 00                	push   $0x0
80106339:	68 98 00 00 00       	push   $0x98
8010633e:	e9 7c f5 ff ff       	jmp    801058bf <alltraps>

80106343 <vector153>:
80106343:	6a 00                	push   $0x0
80106345:	68 99 00 00 00       	push   $0x99
8010634a:	e9 70 f5 ff ff       	jmp    801058bf <alltraps>

8010634f <vector154>:
8010634f:	6a 00                	push   $0x0
80106351:	68 9a 00 00 00       	push   $0x9a
80106356:	e9 64 f5 ff ff       	jmp    801058bf <alltraps>

8010635b <vector155>:
8010635b:	6a 00                	push   $0x0
8010635d:	68 9b 00 00 00       	push   $0x9b
80106362:	e9 58 f5 ff ff       	jmp    801058bf <alltraps>

80106367 <vector156>:
80106367:	6a 00                	push   $0x0
80106369:	68 9c 00 00 00       	push   $0x9c
8010636e:	e9 4c f5 ff ff       	jmp    801058bf <alltraps>

80106373 <vector157>:
80106373:	6a 00                	push   $0x0
80106375:	68 9d 00 00 00       	push   $0x9d
8010637a:	e9 40 f5 ff ff       	jmp    801058bf <alltraps>

8010637f <vector158>:
8010637f:	6a 00                	push   $0x0
80106381:	68 9e 00 00 00       	push   $0x9e
80106386:	e9 34 f5 ff ff       	jmp    801058bf <alltraps>

8010638b <vector159>:
8010638b:	6a 00                	push   $0x0
8010638d:	68 9f 00 00 00       	push   $0x9f
80106392:	e9 28 f5 ff ff       	jmp    801058bf <alltraps>

80106397 <vector160>:
80106397:	6a 00                	push   $0x0
80106399:	68 a0 00 00 00       	push   $0xa0
8010639e:	e9 1c f5 ff ff       	jmp    801058bf <alltraps>

801063a3 <vector161>:
801063a3:	6a 00                	push   $0x0
801063a5:	68 a1 00 00 00       	push   $0xa1
801063aa:	e9 10 f5 ff ff       	jmp    801058bf <alltraps>

801063af <vector162>:
801063af:	6a 00                	push   $0x0
801063b1:	68 a2 00 00 00       	push   $0xa2
801063b6:	e9 04 f5 ff ff       	jmp    801058bf <alltraps>

801063bb <vector163>:
801063bb:	6a 00                	push   $0x0
801063bd:	68 a3 00 00 00       	push   $0xa3
801063c2:	e9 f8 f4 ff ff       	jmp    801058bf <alltraps>

801063c7 <vector164>:
801063c7:	6a 00                	push   $0x0
801063c9:	68 a4 00 00 00       	push   $0xa4
801063ce:	e9 ec f4 ff ff       	jmp    801058bf <alltraps>

801063d3 <vector165>:
801063d3:	6a 00                	push   $0x0
801063d5:	68 a5 00 00 00       	push   $0xa5
801063da:	e9 e0 f4 ff ff       	jmp    801058bf <alltraps>

801063df <vector166>:
801063df:	6a 00                	push   $0x0
801063e1:	68 a6 00 00 00       	push   $0xa6
801063e6:	e9 d4 f4 ff ff       	jmp    801058bf <alltraps>

801063eb <vector167>:
801063eb:	6a 00                	push   $0x0
801063ed:	68 a7 00 00 00       	push   $0xa7
801063f2:	e9 c8 f4 ff ff       	jmp    801058bf <alltraps>

801063f7 <vector168>:
801063f7:	6a 00                	push   $0x0
801063f9:	68 a8 00 00 00       	push   $0xa8
801063fe:	e9 bc f4 ff ff       	jmp    801058bf <alltraps>

80106403 <vector169>:
80106403:	6a 00                	push   $0x0
80106405:	68 a9 00 00 00       	push   $0xa9
8010640a:	e9 b0 f4 ff ff       	jmp    801058bf <alltraps>

8010640f <vector170>:
8010640f:	6a 00                	push   $0x0
80106411:	68 aa 00 00 00       	push   $0xaa
80106416:	e9 a4 f4 ff ff       	jmp    801058bf <alltraps>

8010641b <vector171>:
8010641b:	6a 00                	push   $0x0
8010641d:	68 ab 00 00 00       	push   $0xab
80106422:	e9 98 f4 ff ff       	jmp    801058bf <alltraps>

80106427 <vector172>:
80106427:	6a 00                	push   $0x0
80106429:	68 ac 00 00 00       	push   $0xac
8010642e:	e9 8c f4 ff ff       	jmp    801058bf <alltraps>

80106433 <vector173>:
80106433:	6a 00                	push   $0x0
80106435:	68 ad 00 00 00       	push   $0xad
8010643a:	e9 80 f4 ff ff       	jmp    801058bf <alltraps>

8010643f <vector174>:
8010643f:	6a 00                	push   $0x0
80106441:	68 ae 00 00 00       	push   $0xae
80106446:	e9 74 f4 ff ff       	jmp    801058bf <alltraps>

8010644b <vector175>:
8010644b:	6a 00                	push   $0x0
8010644d:	68 af 00 00 00       	push   $0xaf
80106452:	e9 68 f4 ff ff       	jmp    801058bf <alltraps>

80106457 <vector176>:
80106457:	6a 00                	push   $0x0
80106459:	68 b0 00 00 00       	push   $0xb0
8010645e:	e9 5c f4 ff ff       	jmp    801058bf <alltraps>

80106463 <vector177>:
80106463:	6a 00                	push   $0x0
80106465:	68 b1 00 00 00       	push   $0xb1
8010646a:	e9 50 f4 ff ff       	jmp    801058bf <alltraps>

8010646f <vector178>:
8010646f:	6a 00                	push   $0x0
80106471:	68 b2 00 00 00       	push   $0xb2
80106476:	e9 44 f4 ff ff       	jmp    801058bf <alltraps>

8010647b <vector179>:
8010647b:	6a 00                	push   $0x0
8010647d:	68 b3 00 00 00       	push   $0xb3
80106482:	e9 38 f4 ff ff       	jmp    801058bf <alltraps>

80106487 <vector180>:
80106487:	6a 00                	push   $0x0
80106489:	68 b4 00 00 00       	push   $0xb4
8010648e:	e9 2c f4 ff ff       	jmp    801058bf <alltraps>

80106493 <vector181>:
80106493:	6a 00                	push   $0x0
80106495:	68 b5 00 00 00       	push   $0xb5
8010649a:	e9 20 f4 ff ff       	jmp    801058bf <alltraps>

8010649f <vector182>:
8010649f:	6a 00                	push   $0x0
801064a1:	68 b6 00 00 00       	push   $0xb6
801064a6:	e9 14 f4 ff ff       	jmp    801058bf <alltraps>

801064ab <vector183>:
801064ab:	6a 00                	push   $0x0
801064ad:	68 b7 00 00 00       	push   $0xb7
801064b2:	e9 08 f4 ff ff       	jmp    801058bf <alltraps>

801064b7 <vector184>:
801064b7:	6a 00                	push   $0x0
801064b9:	68 b8 00 00 00       	push   $0xb8
801064be:	e9 fc f3 ff ff       	jmp    801058bf <alltraps>

801064c3 <vector185>:
801064c3:	6a 00                	push   $0x0
801064c5:	68 b9 00 00 00       	push   $0xb9
801064ca:	e9 f0 f3 ff ff       	jmp    801058bf <alltraps>

801064cf <vector186>:
801064cf:	6a 00                	push   $0x0
801064d1:	68 ba 00 00 00       	push   $0xba
801064d6:	e9 e4 f3 ff ff       	jmp    801058bf <alltraps>

801064db <vector187>:
801064db:	6a 00                	push   $0x0
801064dd:	68 bb 00 00 00       	push   $0xbb
801064e2:	e9 d8 f3 ff ff       	jmp    801058bf <alltraps>

801064e7 <vector188>:
801064e7:	6a 00                	push   $0x0
801064e9:	68 bc 00 00 00       	push   $0xbc
801064ee:	e9 cc f3 ff ff       	jmp    801058bf <alltraps>

801064f3 <vector189>:
801064f3:	6a 00                	push   $0x0
801064f5:	68 bd 00 00 00       	push   $0xbd
801064fa:	e9 c0 f3 ff ff       	jmp    801058bf <alltraps>

801064ff <vector190>:
801064ff:	6a 00                	push   $0x0
80106501:	68 be 00 00 00       	push   $0xbe
80106506:	e9 b4 f3 ff ff       	jmp    801058bf <alltraps>

8010650b <vector191>:
8010650b:	6a 00                	push   $0x0
8010650d:	68 bf 00 00 00       	push   $0xbf
80106512:	e9 a8 f3 ff ff       	jmp    801058bf <alltraps>

80106517 <vector192>:
80106517:	6a 00                	push   $0x0
80106519:	68 c0 00 00 00       	push   $0xc0
8010651e:	e9 9c f3 ff ff       	jmp    801058bf <alltraps>

80106523 <vector193>:
80106523:	6a 00                	push   $0x0
80106525:	68 c1 00 00 00       	push   $0xc1
8010652a:	e9 90 f3 ff ff       	jmp    801058bf <alltraps>

8010652f <vector194>:
8010652f:	6a 00                	push   $0x0
80106531:	68 c2 00 00 00       	push   $0xc2
80106536:	e9 84 f3 ff ff       	jmp    801058bf <alltraps>

8010653b <vector195>:
8010653b:	6a 00                	push   $0x0
8010653d:	68 c3 00 00 00       	push   $0xc3
80106542:	e9 78 f3 ff ff       	jmp    801058bf <alltraps>

80106547 <vector196>:
80106547:	6a 00                	push   $0x0
80106549:	68 c4 00 00 00       	push   $0xc4
8010654e:	e9 6c f3 ff ff       	jmp    801058bf <alltraps>

80106553 <vector197>:
80106553:	6a 00                	push   $0x0
80106555:	68 c5 00 00 00       	push   $0xc5
8010655a:	e9 60 f3 ff ff       	jmp    801058bf <alltraps>

8010655f <vector198>:
8010655f:	6a 00                	push   $0x0
80106561:	68 c6 00 00 00       	push   $0xc6
80106566:	e9 54 f3 ff ff       	jmp    801058bf <alltraps>

8010656b <vector199>:
8010656b:	6a 00                	push   $0x0
8010656d:	68 c7 00 00 00       	push   $0xc7
80106572:	e9 48 f3 ff ff       	jmp    801058bf <alltraps>

80106577 <vector200>:
80106577:	6a 00                	push   $0x0
80106579:	68 c8 00 00 00       	push   $0xc8
8010657e:	e9 3c f3 ff ff       	jmp    801058bf <alltraps>

80106583 <vector201>:
80106583:	6a 00                	push   $0x0
80106585:	68 c9 00 00 00       	push   $0xc9
8010658a:	e9 30 f3 ff ff       	jmp    801058bf <alltraps>

8010658f <vector202>:
8010658f:	6a 00                	push   $0x0
80106591:	68 ca 00 00 00       	push   $0xca
80106596:	e9 24 f3 ff ff       	jmp    801058bf <alltraps>

8010659b <vector203>:
8010659b:	6a 00                	push   $0x0
8010659d:	68 cb 00 00 00       	push   $0xcb
801065a2:	e9 18 f3 ff ff       	jmp    801058bf <alltraps>

801065a7 <vector204>:
801065a7:	6a 00                	push   $0x0
801065a9:	68 cc 00 00 00       	push   $0xcc
801065ae:	e9 0c f3 ff ff       	jmp    801058bf <alltraps>

801065b3 <vector205>:
801065b3:	6a 00                	push   $0x0
801065b5:	68 cd 00 00 00       	push   $0xcd
801065ba:	e9 00 f3 ff ff       	jmp    801058bf <alltraps>

801065bf <vector206>:
801065bf:	6a 00                	push   $0x0
801065c1:	68 ce 00 00 00       	push   $0xce
801065c6:	e9 f4 f2 ff ff       	jmp    801058bf <alltraps>

801065cb <vector207>:
801065cb:	6a 00                	push   $0x0
801065cd:	68 cf 00 00 00       	push   $0xcf
801065d2:	e9 e8 f2 ff ff       	jmp    801058bf <alltraps>

801065d7 <vector208>:
801065d7:	6a 00                	push   $0x0
801065d9:	68 d0 00 00 00       	push   $0xd0
801065de:	e9 dc f2 ff ff       	jmp    801058bf <alltraps>

801065e3 <vector209>:
801065e3:	6a 00                	push   $0x0
801065e5:	68 d1 00 00 00       	push   $0xd1
801065ea:	e9 d0 f2 ff ff       	jmp    801058bf <alltraps>

801065ef <vector210>:
801065ef:	6a 00                	push   $0x0
801065f1:	68 d2 00 00 00       	push   $0xd2
801065f6:	e9 c4 f2 ff ff       	jmp    801058bf <alltraps>

801065fb <vector211>:
801065fb:	6a 00                	push   $0x0
801065fd:	68 d3 00 00 00       	push   $0xd3
80106602:	e9 b8 f2 ff ff       	jmp    801058bf <alltraps>

80106607 <vector212>:
80106607:	6a 00                	push   $0x0
80106609:	68 d4 00 00 00       	push   $0xd4
8010660e:	e9 ac f2 ff ff       	jmp    801058bf <alltraps>

80106613 <vector213>:
80106613:	6a 00                	push   $0x0
80106615:	68 d5 00 00 00       	push   $0xd5
8010661a:	e9 a0 f2 ff ff       	jmp    801058bf <alltraps>

8010661f <vector214>:
8010661f:	6a 00                	push   $0x0
80106621:	68 d6 00 00 00       	push   $0xd6
80106626:	e9 94 f2 ff ff       	jmp    801058bf <alltraps>

8010662b <vector215>:
8010662b:	6a 00                	push   $0x0
8010662d:	68 d7 00 00 00       	push   $0xd7
80106632:	e9 88 f2 ff ff       	jmp    801058bf <alltraps>

80106637 <vector216>:
80106637:	6a 00                	push   $0x0
80106639:	68 d8 00 00 00       	push   $0xd8
8010663e:	e9 7c f2 ff ff       	jmp    801058bf <alltraps>

80106643 <vector217>:
80106643:	6a 00                	push   $0x0
80106645:	68 d9 00 00 00       	push   $0xd9
8010664a:	e9 70 f2 ff ff       	jmp    801058bf <alltraps>

8010664f <vector218>:
8010664f:	6a 00                	push   $0x0
80106651:	68 da 00 00 00       	push   $0xda
80106656:	e9 64 f2 ff ff       	jmp    801058bf <alltraps>

8010665b <vector219>:
8010665b:	6a 00                	push   $0x0
8010665d:	68 db 00 00 00       	push   $0xdb
80106662:	e9 58 f2 ff ff       	jmp    801058bf <alltraps>

80106667 <vector220>:
80106667:	6a 00                	push   $0x0
80106669:	68 dc 00 00 00       	push   $0xdc
8010666e:	e9 4c f2 ff ff       	jmp    801058bf <alltraps>

80106673 <vector221>:
80106673:	6a 00                	push   $0x0
80106675:	68 dd 00 00 00       	push   $0xdd
8010667a:	e9 40 f2 ff ff       	jmp    801058bf <alltraps>

8010667f <vector222>:
8010667f:	6a 00                	push   $0x0
80106681:	68 de 00 00 00       	push   $0xde
80106686:	e9 34 f2 ff ff       	jmp    801058bf <alltraps>

8010668b <vector223>:
8010668b:	6a 00                	push   $0x0
8010668d:	68 df 00 00 00       	push   $0xdf
80106692:	e9 28 f2 ff ff       	jmp    801058bf <alltraps>

80106697 <vector224>:
80106697:	6a 00                	push   $0x0
80106699:	68 e0 00 00 00       	push   $0xe0
8010669e:	e9 1c f2 ff ff       	jmp    801058bf <alltraps>

801066a3 <vector225>:
801066a3:	6a 00                	push   $0x0
801066a5:	68 e1 00 00 00       	push   $0xe1
801066aa:	e9 10 f2 ff ff       	jmp    801058bf <alltraps>

801066af <vector226>:
801066af:	6a 00                	push   $0x0
801066b1:	68 e2 00 00 00       	push   $0xe2
801066b6:	e9 04 f2 ff ff       	jmp    801058bf <alltraps>

801066bb <vector227>:
801066bb:	6a 00                	push   $0x0
801066bd:	68 e3 00 00 00       	push   $0xe3
801066c2:	e9 f8 f1 ff ff       	jmp    801058bf <alltraps>

801066c7 <vector228>:
801066c7:	6a 00                	push   $0x0
801066c9:	68 e4 00 00 00       	push   $0xe4
801066ce:	e9 ec f1 ff ff       	jmp    801058bf <alltraps>

801066d3 <vector229>:
801066d3:	6a 00                	push   $0x0
801066d5:	68 e5 00 00 00       	push   $0xe5
801066da:	e9 e0 f1 ff ff       	jmp    801058bf <alltraps>

801066df <vector230>:
801066df:	6a 00                	push   $0x0
801066e1:	68 e6 00 00 00       	push   $0xe6
801066e6:	e9 d4 f1 ff ff       	jmp    801058bf <alltraps>

801066eb <vector231>:
801066eb:	6a 00                	push   $0x0
801066ed:	68 e7 00 00 00       	push   $0xe7
801066f2:	e9 c8 f1 ff ff       	jmp    801058bf <alltraps>

801066f7 <vector232>:
801066f7:	6a 00                	push   $0x0
801066f9:	68 e8 00 00 00       	push   $0xe8
801066fe:	e9 bc f1 ff ff       	jmp    801058bf <alltraps>

80106703 <vector233>:
80106703:	6a 00                	push   $0x0
80106705:	68 e9 00 00 00       	push   $0xe9
8010670a:	e9 b0 f1 ff ff       	jmp    801058bf <alltraps>

8010670f <vector234>:
8010670f:	6a 00                	push   $0x0
80106711:	68 ea 00 00 00       	push   $0xea
80106716:	e9 a4 f1 ff ff       	jmp    801058bf <alltraps>

8010671b <vector235>:
8010671b:	6a 00                	push   $0x0
8010671d:	68 eb 00 00 00       	push   $0xeb
80106722:	e9 98 f1 ff ff       	jmp    801058bf <alltraps>

80106727 <vector236>:
80106727:	6a 00                	push   $0x0
80106729:	68 ec 00 00 00       	push   $0xec
8010672e:	e9 8c f1 ff ff       	jmp    801058bf <alltraps>

80106733 <vector237>:
80106733:	6a 00                	push   $0x0
80106735:	68 ed 00 00 00       	push   $0xed
8010673a:	e9 80 f1 ff ff       	jmp    801058bf <alltraps>

8010673f <vector238>:
8010673f:	6a 00                	push   $0x0
80106741:	68 ee 00 00 00       	push   $0xee
80106746:	e9 74 f1 ff ff       	jmp    801058bf <alltraps>

8010674b <vector239>:
8010674b:	6a 00                	push   $0x0
8010674d:	68 ef 00 00 00       	push   $0xef
80106752:	e9 68 f1 ff ff       	jmp    801058bf <alltraps>

80106757 <vector240>:
80106757:	6a 00                	push   $0x0
80106759:	68 f0 00 00 00       	push   $0xf0
8010675e:	e9 5c f1 ff ff       	jmp    801058bf <alltraps>

80106763 <vector241>:
80106763:	6a 00                	push   $0x0
80106765:	68 f1 00 00 00       	push   $0xf1
8010676a:	e9 50 f1 ff ff       	jmp    801058bf <alltraps>

8010676f <vector242>:
8010676f:	6a 00                	push   $0x0
80106771:	68 f2 00 00 00       	push   $0xf2
80106776:	e9 44 f1 ff ff       	jmp    801058bf <alltraps>

8010677b <vector243>:
8010677b:	6a 00                	push   $0x0
8010677d:	68 f3 00 00 00       	push   $0xf3
80106782:	e9 38 f1 ff ff       	jmp    801058bf <alltraps>

80106787 <vector244>:
80106787:	6a 00                	push   $0x0
80106789:	68 f4 00 00 00       	push   $0xf4
8010678e:	e9 2c f1 ff ff       	jmp    801058bf <alltraps>

80106793 <vector245>:
80106793:	6a 00                	push   $0x0
80106795:	68 f5 00 00 00       	push   $0xf5
8010679a:	e9 20 f1 ff ff       	jmp    801058bf <alltraps>

8010679f <vector246>:
8010679f:	6a 00                	push   $0x0
801067a1:	68 f6 00 00 00       	push   $0xf6
801067a6:	e9 14 f1 ff ff       	jmp    801058bf <alltraps>

801067ab <vector247>:
801067ab:	6a 00                	push   $0x0
801067ad:	68 f7 00 00 00       	push   $0xf7
801067b2:	e9 08 f1 ff ff       	jmp    801058bf <alltraps>

801067b7 <vector248>:
801067b7:	6a 00                	push   $0x0
801067b9:	68 f8 00 00 00       	push   $0xf8
801067be:	e9 fc f0 ff ff       	jmp    801058bf <alltraps>

801067c3 <vector249>:
801067c3:	6a 00                	push   $0x0
801067c5:	68 f9 00 00 00       	push   $0xf9
801067ca:	e9 f0 f0 ff ff       	jmp    801058bf <alltraps>

801067cf <vector250>:
801067cf:	6a 00                	push   $0x0
801067d1:	68 fa 00 00 00       	push   $0xfa
801067d6:	e9 e4 f0 ff ff       	jmp    801058bf <alltraps>

801067db <vector251>:
801067db:	6a 00                	push   $0x0
801067dd:	68 fb 00 00 00       	push   $0xfb
801067e2:	e9 d8 f0 ff ff       	jmp    801058bf <alltraps>

801067e7 <vector252>:
801067e7:	6a 00                	push   $0x0
801067e9:	68 fc 00 00 00       	push   $0xfc
801067ee:	e9 cc f0 ff ff       	jmp    801058bf <alltraps>

801067f3 <vector253>:
801067f3:	6a 00                	push   $0x0
801067f5:	68 fd 00 00 00       	push   $0xfd
801067fa:	e9 c0 f0 ff ff       	jmp    801058bf <alltraps>

801067ff <vector254>:
801067ff:	6a 00                	push   $0x0
80106801:	68 fe 00 00 00       	push   $0xfe
80106806:	e9 b4 f0 ff ff       	jmp    801058bf <alltraps>

8010680b <vector255>:
8010680b:	6a 00                	push   $0x0
8010680d:	68 ff 00 00 00       	push   $0xff
80106812:	e9 a8 f0 ff ff       	jmp    801058bf <alltraps>
80106817:	66 90                	xchg   %ax,%ax
80106819:	66 90                	xchg   %ax,%ax
8010681b:	66 90                	xchg   %ax,%ax
8010681d:	66 90                	xchg   %ax,%ax
8010681f:	90                   	nop

80106820 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106820:	55                   	push   %ebp
80106821:	89 e5                	mov    %esp,%ebp
80106823:	57                   	push   %edi
80106824:	56                   	push   %esi
80106825:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106826:	89 d3                	mov    %edx,%ebx
{
80106828:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
8010682a:	c1 eb 16             	shr    $0x16,%ebx
8010682d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80106830:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106833:	8b 06                	mov    (%esi),%eax
80106835:	a8 01                	test   $0x1,%al
80106837:	74 27                	je     80106860 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106839:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010683e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106844:	c1 ef 0a             	shr    $0xa,%edi
}
80106847:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
8010684a:	89 fa                	mov    %edi,%edx
8010684c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106852:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106855:	5b                   	pop    %ebx
80106856:	5e                   	pop    %esi
80106857:	5f                   	pop    %edi
80106858:	5d                   	pop    %ebp
80106859:	c3                   	ret    
8010685a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106860:	85 c9                	test   %ecx,%ecx
80106862:	74 2c                	je     80106890 <walkpgdir+0x70>
80106864:	e8 67 bc ff ff       	call   801024d0 <kalloc>
80106869:	85 c0                	test   %eax,%eax
8010686b:	89 c3                	mov    %eax,%ebx
8010686d:	74 21                	je     80106890 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
8010686f:	83 ec 04             	sub    $0x4,%esp
80106872:	68 00 10 00 00       	push   $0x1000
80106877:	6a 00                	push   $0x0
80106879:	50                   	push   %eax
8010687a:	e8 91 dd ff ff       	call   80104610 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010687f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106885:	83 c4 10             	add    $0x10,%esp
80106888:	83 c8 07             	or     $0x7,%eax
8010688b:	89 06                	mov    %eax,(%esi)
8010688d:	eb b5                	jmp    80106844 <walkpgdir+0x24>
8010688f:	90                   	nop
}
80106890:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80106893:	31 c0                	xor    %eax,%eax
}
80106895:	5b                   	pop    %ebx
80106896:	5e                   	pop    %esi
80106897:	5f                   	pop    %edi
80106898:	5d                   	pop    %ebp
80106899:	c3                   	ret    
8010689a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801068a0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801068a0:	55                   	push   %ebp
801068a1:	89 e5                	mov    %esp,%ebp
801068a3:	57                   	push   %edi
801068a4:	56                   	push   %esi
801068a5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801068a6:	89 d3                	mov    %edx,%ebx
801068a8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
801068ae:	83 ec 1c             	sub    $0x1c,%esp
801068b1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801068b4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801068b8:	8b 7d 08             	mov    0x8(%ebp),%edi
801068bb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801068c0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801068c3:	8b 45 0c             	mov    0xc(%ebp),%eax
801068c6:	29 df                	sub    %ebx,%edi
801068c8:	83 c8 01             	or     $0x1,%eax
801068cb:	89 45 dc             	mov    %eax,-0x24(%ebp)
801068ce:	eb 15                	jmp    801068e5 <mappages+0x45>
    if(*pte & PTE_P)
801068d0:	f6 00 01             	testb  $0x1,(%eax)
801068d3:	75 45                	jne    8010691a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
801068d5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
801068d8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
801068db:	89 30                	mov    %esi,(%eax)
    if(a == last)
801068dd:	74 31                	je     80106910 <mappages+0x70>
      break;
    a += PGSIZE;
801068df:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801068e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801068e8:	b9 01 00 00 00       	mov    $0x1,%ecx
801068ed:	89 da                	mov    %ebx,%edx
801068ef:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
801068f2:	e8 29 ff ff ff       	call   80106820 <walkpgdir>
801068f7:	85 c0                	test   %eax,%eax
801068f9:	75 d5                	jne    801068d0 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
801068fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801068fe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106903:	5b                   	pop    %ebx
80106904:	5e                   	pop    %esi
80106905:	5f                   	pop    %edi
80106906:	5d                   	pop    %ebp
80106907:	c3                   	ret    
80106908:	90                   	nop
80106909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106910:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106913:	31 c0                	xor    %eax,%eax
}
80106915:	5b                   	pop    %ebx
80106916:	5e                   	pop    %esi
80106917:	5f                   	pop    %edi
80106918:	5d                   	pop    %ebp
80106919:	c3                   	ret    
      panic("remap");
8010691a:	83 ec 0c             	sub    $0xc,%esp
8010691d:	68 94 7a 10 80       	push   $0x80107a94
80106922:	e8 69 9a ff ff       	call   80100390 <panic>
80106927:	89 f6                	mov    %esi,%esi
80106929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106930 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106930:	55                   	push   %ebp
80106931:	89 e5                	mov    %esp,%ebp
80106933:	57                   	push   %edi
80106934:	56                   	push   %esi
80106935:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106936:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010693c:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
8010693e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106944:	83 ec 1c             	sub    $0x1c,%esp
80106947:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010694a:	39 d3                	cmp    %edx,%ebx
8010694c:	73 66                	jae    801069b4 <deallocuvm.part.0+0x84>
8010694e:	89 d6                	mov    %edx,%esi
80106950:	eb 3d                	jmp    8010698f <deallocuvm.part.0+0x5f>
80106952:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106958:	8b 10                	mov    (%eax),%edx
8010695a:	f6 c2 01             	test   $0x1,%dl
8010695d:	74 26                	je     80106985 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
8010695f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106965:	74 58                	je     801069bf <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106967:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010696a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106970:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
80106973:	52                   	push   %edx
80106974:	e8 a7 b9 ff ff       	call   80102320 <kfree>
      *pte = 0;
80106979:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010697c:	83 c4 10             	add    $0x10,%esp
8010697f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80106985:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010698b:	39 f3                	cmp    %esi,%ebx
8010698d:	73 25                	jae    801069b4 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010698f:	31 c9                	xor    %ecx,%ecx
80106991:	89 da                	mov    %ebx,%edx
80106993:	89 f8                	mov    %edi,%eax
80106995:	e8 86 fe ff ff       	call   80106820 <walkpgdir>
    if(!pte)
8010699a:	85 c0                	test   %eax,%eax
8010699c:	75 ba                	jne    80106958 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
8010699e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
801069a4:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
801069aa:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801069b0:	39 f3                	cmp    %esi,%ebx
801069b2:	72 db                	jb     8010698f <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
801069b4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801069b7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801069ba:	5b                   	pop    %ebx
801069bb:	5e                   	pop    %esi
801069bc:	5f                   	pop    %edi
801069bd:	5d                   	pop    %ebp
801069be:	c3                   	ret    
        panic("kfree");
801069bf:	83 ec 0c             	sub    $0xc,%esp
801069c2:	68 a6 73 10 80       	push   $0x801073a6
801069c7:	e8 c4 99 ff ff       	call   80100390 <panic>
801069cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801069d0 <seginit>:
{
801069d0:	55                   	push   %ebp
801069d1:	89 e5                	mov    %esp,%ebp
801069d3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
801069d6:	e8 05 ce ff ff       	call   801037e0 <cpuid>
801069db:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
801069e1:	ba 2f 00 00 00       	mov    $0x2f,%edx
801069e6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801069ea:	c7 80 f8 27 11 80 ff 	movl   $0xffff,-0x7feed808(%eax)
801069f1:	ff 00 00 
801069f4:	c7 80 fc 27 11 80 00 	movl   $0xcf9a00,-0x7feed804(%eax)
801069fb:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801069fe:	c7 80 00 28 11 80 ff 	movl   $0xffff,-0x7feed800(%eax)
80106a05:	ff 00 00 
80106a08:	c7 80 04 28 11 80 00 	movl   $0xcf9200,-0x7feed7fc(%eax)
80106a0f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106a12:	c7 80 08 28 11 80 ff 	movl   $0xffff,-0x7feed7f8(%eax)
80106a19:	ff 00 00 
80106a1c:	c7 80 0c 28 11 80 00 	movl   $0xcffa00,-0x7feed7f4(%eax)
80106a23:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106a26:	c7 80 10 28 11 80 ff 	movl   $0xffff,-0x7feed7f0(%eax)
80106a2d:	ff 00 00 
80106a30:	c7 80 14 28 11 80 00 	movl   $0xcff200,-0x7feed7ec(%eax)
80106a37:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106a3a:	05 f0 27 11 80       	add    $0x801127f0,%eax
  pd[1] = (uint)p;
80106a3f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106a43:	c1 e8 10             	shr    $0x10,%eax
80106a46:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106a4a:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106a4d:	0f 01 10             	lgdtl  (%eax)
}
80106a50:	c9                   	leave  
80106a51:	c3                   	ret    
80106a52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106a60 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106a60:	a1 a4 55 11 80       	mov    0x801155a4,%eax
{
80106a65:	55                   	push   %ebp
80106a66:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106a68:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106a6d:	0f 22 d8             	mov    %eax,%cr3
}
80106a70:	5d                   	pop    %ebp
80106a71:	c3                   	ret    
80106a72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106a80 <switchuvm>:
{
80106a80:	55                   	push   %ebp
80106a81:	89 e5                	mov    %esp,%ebp
80106a83:	57                   	push   %edi
80106a84:	56                   	push   %esi
80106a85:	53                   	push   %ebx
80106a86:	83 ec 1c             	sub    $0x1c,%esp
80106a89:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
80106a8c:	85 db                	test   %ebx,%ebx
80106a8e:	0f 84 cb 00 00 00    	je     80106b5f <switchuvm+0xdf>
  if(p->kstack == 0)
80106a94:	8b 43 08             	mov    0x8(%ebx),%eax
80106a97:	85 c0                	test   %eax,%eax
80106a99:	0f 84 da 00 00 00    	je     80106b79 <switchuvm+0xf9>
  if(p->pgdir == 0)
80106a9f:	8b 43 04             	mov    0x4(%ebx),%eax
80106aa2:	85 c0                	test   %eax,%eax
80106aa4:	0f 84 c2 00 00 00    	je     80106b6c <switchuvm+0xec>
  pushcli();
80106aaa:	e8 a1 d9 ff ff       	call   80104450 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106aaf:	e8 ac cc ff ff       	call   80103760 <mycpu>
80106ab4:	89 c6                	mov    %eax,%esi
80106ab6:	e8 a5 cc ff ff       	call   80103760 <mycpu>
80106abb:	89 c7                	mov    %eax,%edi
80106abd:	e8 9e cc ff ff       	call   80103760 <mycpu>
80106ac2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106ac5:	83 c7 08             	add    $0x8,%edi
80106ac8:	e8 93 cc ff ff       	call   80103760 <mycpu>
80106acd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106ad0:	83 c0 08             	add    $0x8,%eax
80106ad3:	ba 67 00 00 00       	mov    $0x67,%edx
80106ad8:	c1 e8 18             	shr    $0x18,%eax
80106adb:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80106ae2:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80106ae9:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106aef:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106af4:	83 c1 08             	add    $0x8,%ecx
80106af7:	c1 e9 10             	shr    $0x10,%ecx
80106afa:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80106b00:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106b05:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106b0c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80106b11:	e8 4a cc ff ff       	call   80103760 <mycpu>
80106b16:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106b1d:	e8 3e cc ff ff       	call   80103760 <mycpu>
80106b22:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106b26:	8b 73 08             	mov    0x8(%ebx),%esi
80106b29:	e8 32 cc ff ff       	call   80103760 <mycpu>
80106b2e:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106b34:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106b37:	e8 24 cc ff ff       	call   80103760 <mycpu>
80106b3c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106b40:	b8 28 00 00 00       	mov    $0x28,%eax
80106b45:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106b48:	8b 43 04             	mov    0x4(%ebx),%eax
80106b4b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106b50:	0f 22 d8             	mov    %eax,%cr3
}
80106b53:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b56:	5b                   	pop    %ebx
80106b57:	5e                   	pop    %esi
80106b58:	5f                   	pop    %edi
80106b59:	5d                   	pop    %ebp
  popcli();
80106b5a:	e9 f1 d9 ff ff       	jmp    80104550 <popcli>
    panic("switchuvm: no process");
80106b5f:	83 ec 0c             	sub    $0xc,%esp
80106b62:	68 9a 7a 10 80       	push   $0x80107a9a
80106b67:	e8 24 98 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
80106b6c:	83 ec 0c             	sub    $0xc,%esp
80106b6f:	68 c5 7a 10 80       	push   $0x80107ac5
80106b74:	e8 17 98 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
80106b79:	83 ec 0c             	sub    $0xc,%esp
80106b7c:	68 b0 7a 10 80       	push   $0x80107ab0
80106b81:	e8 0a 98 ff ff       	call   80100390 <panic>
80106b86:	8d 76 00             	lea    0x0(%esi),%esi
80106b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b90 <inituvm>:
{
80106b90:	55                   	push   %ebp
80106b91:	89 e5                	mov    %esp,%ebp
80106b93:	57                   	push   %edi
80106b94:	56                   	push   %esi
80106b95:	53                   	push   %ebx
80106b96:	83 ec 1c             	sub    $0x1c,%esp
80106b99:	8b 75 10             	mov    0x10(%ebp),%esi
80106b9c:	8b 45 08             	mov    0x8(%ebp),%eax
80106b9f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80106ba2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80106ba8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106bab:	77 49                	ja     80106bf6 <inituvm+0x66>
  mem = kalloc();
80106bad:	e8 1e b9 ff ff       	call   801024d0 <kalloc>
  memset(mem, 0, PGSIZE);
80106bb2:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80106bb5:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106bb7:	68 00 10 00 00       	push   $0x1000
80106bbc:	6a 00                	push   $0x0
80106bbe:	50                   	push   %eax
80106bbf:	e8 4c da ff ff       	call   80104610 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106bc4:	58                   	pop    %eax
80106bc5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106bcb:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106bd0:	5a                   	pop    %edx
80106bd1:	6a 06                	push   $0x6
80106bd3:	50                   	push   %eax
80106bd4:	31 d2                	xor    %edx,%edx
80106bd6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106bd9:	e8 c2 fc ff ff       	call   801068a0 <mappages>
  memmove(mem, init, sz);
80106bde:	89 75 10             	mov    %esi,0x10(%ebp)
80106be1:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106be4:	83 c4 10             	add    $0x10,%esp
80106be7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106bea:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106bed:	5b                   	pop    %ebx
80106bee:	5e                   	pop    %esi
80106bef:	5f                   	pop    %edi
80106bf0:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106bf1:	e9 ca da ff ff       	jmp    801046c0 <memmove>
    panic("inituvm: more than a page");
80106bf6:	83 ec 0c             	sub    $0xc,%esp
80106bf9:	68 d9 7a 10 80       	push   $0x80107ad9
80106bfe:	e8 8d 97 ff ff       	call   80100390 <panic>
80106c03:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106c10 <loaduvm>:
{
80106c10:	55                   	push   %ebp
80106c11:	89 e5                	mov    %esp,%ebp
80106c13:	57                   	push   %edi
80106c14:	56                   	push   %esi
80106c15:	53                   	push   %ebx
80106c16:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80106c19:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106c20:	0f 85 91 00 00 00    	jne    80106cb7 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80106c26:	8b 75 18             	mov    0x18(%ebp),%esi
80106c29:	31 db                	xor    %ebx,%ebx
80106c2b:	85 f6                	test   %esi,%esi
80106c2d:	75 1a                	jne    80106c49 <loaduvm+0x39>
80106c2f:	eb 6f                	jmp    80106ca0 <loaduvm+0x90>
80106c31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c38:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106c3e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106c44:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106c47:	76 57                	jbe    80106ca0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106c49:	8b 55 0c             	mov    0xc(%ebp),%edx
80106c4c:	8b 45 08             	mov    0x8(%ebp),%eax
80106c4f:	31 c9                	xor    %ecx,%ecx
80106c51:	01 da                	add    %ebx,%edx
80106c53:	e8 c8 fb ff ff       	call   80106820 <walkpgdir>
80106c58:	85 c0                	test   %eax,%eax
80106c5a:	74 4e                	je     80106caa <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
80106c5c:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106c5e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80106c61:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80106c66:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106c6b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106c71:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106c74:	01 d9                	add    %ebx,%ecx
80106c76:	05 00 00 00 80       	add    $0x80000000,%eax
80106c7b:	57                   	push   %edi
80106c7c:	51                   	push   %ecx
80106c7d:	50                   	push   %eax
80106c7e:	ff 75 10             	pushl  0x10(%ebp)
80106c81:	e8 ea ac ff ff       	call   80101970 <readi>
80106c86:	83 c4 10             	add    $0x10,%esp
80106c89:	39 f8                	cmp    %edi,%eax
80106c8b:	74 ab                	je     80106c38 <loaduvm+0x28>
}
80106c8d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106c90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106c95:	5b                   	pop    %ebx
80106c96:	5e                   	pop    %esi
80106c97:	5f                   	pop    %edi
80106c98:	5d                   	pop    %ebp
80106c99:	c3                   	ret    
80106c9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106ca0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106ca3:	31 c0                	xor    %eax,%eax
}
80106ca5:	5b                   	pop    %ebx
80106ca6:	5e                   	pop    %esi
80106ca7:	5f                   	pop    %edi
80106ca8:	5d                   	pop    %ebp
80106ca9:	c3                   	ret    
      panic("loaduvm: address should exist");
80106caa:	83 ec 0c             	sub    $0xc,%esp
80106cad:	68 f3 7a 10 80       	push   $0x80107af3
80106cb2:	e8 d9 96 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80106cb7:	83 ec 0c             	sub    $0xc,%esp
80106cba:	68 94 7b 10 80       	push   $0x80107b94
80106cbf:	e8 cc 96 ff ff       	call   80100390 <panic>
80106cc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106cca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106cd0 <allocuvm>:
{
80106cd0:	55                   	push   %ebp
80106cd1:	89 e5                	mov    %esp,%ebp
80106cd3:	57                   	push   %edi
80106cd4:	56                   	push   %esi
80106cd5:	53                   	push   %ebx
80106cd6:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80106cd9:	8b 7d 10             	mov    0x10(%ebp),%edi
80106cdc:	85 ff                	test   %edi,%edi
80106cde:	0f 88 8e 00 00 00    	js     80106d72 <allocuvm+0xa2>
  if(newsz < oldsz)
80106ce4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106ce7:	0f 82 93 00 00 00    	jb     80106d80 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
80106ced:	8b 45 0c             	mov    0xc(%ebp),%eax
80106cf0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106cf6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106cfc:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106cff:	0f 86 7e 00 00 00    	jbe    80106d83 <allocuvm+0xb3>
80106d05:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106d08:	8b 7d 08             	mov    0x8(%ebp),%edi
80106d0b:	eb 42                	jmp    80106d4f <allocuvm+0x7f>
80106d0d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80106d10:	83 ec 04             	sub    $0x4,%esp
80106d13:	68 00 10 00 00       	push   $0x1000
80106d18:	6a 00                	push   $0x0
80106d1a:	50                   	push   %eax
80106d1b:	e8 f0 d8 ff ff       	call   80104610 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106d20:	58                   	pop    %eax
80106d21:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106d27:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106d2c:	5a                   	pop    %edx
80106d2d:	6a 06                	push   $0x6
80106d2f:	50                   	push   %eax
80106d30:	89 da                	mov    %ebx,%edx
80106d32:	89 f8                	mov    %edi,%eax
80106d34:	e8 67 fb ff ff       	call   801068a0 <mappages>
80106d39:	83 c4 10             	add    $0x10,%esp
80106d3c:	85 c0                	test   %eax,%eax
80106d3e:	78 50                	js     80106d90 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
80106d40:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106d46:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106d49:	0f 86 81 00 00 00    	jbe    80106dd0 <allocuvm+0x100>
    mem = kalloc();
80106d4f:	e8 7c b7 ff ff       	call   801024d0 <kalloc>
    if(mem == 0){
80106d54:	85 c0                	test   %eax,%eax
    mem = kalloc();
80106d56:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106d58:	75 b6                	jne    80106d10 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106d5a:	83 ec 0c             	sub    $0xc,%esp
80106d5d:	68 11 7b 10 80       	push   $0x80107b11
80106d62:	e8 f9 98 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80106d67:	83 c4 10             	add    $0x10,%esp
80106d6a:	8b 45 0c             	mov    0xc(%ebp),%eax
80106d6d:	39 45 10             	cmp    %eax,0x10(%ebp)
80106d70:	77 6e                	ja     80106de0 <allocuvm+0x110>
}
80106d72:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80106d75:	31 ff                	xor    %edi,%edi
}
80106d77:	89 f8                	mov    %edi,%eax
80106d79:	5b                   	pop    %ebx
80106d7a:	5e                   	pop    %esi
80106d7b:	5f                   	pop    %edi
80106d7c:	5d                   	pop    %ebp
80106d7d:	c3                   	ret    
80106d7e:	66 90                	xchg   %ax,%ax
    return oldsz;
80106d80:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80106d83:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d86:	89 f8                	mov    %edi,%eax
80106d88:	5b                   	pop    %ebx
80106d89:	5e                   	pop    %esi
80106d8a:	5f                   	pop    %edi
80106d8b:	5d                   	pop    %ebp
80106d8c:	c3                   	ret    
80106d8d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80106d90:	83 ec 0c             	sub    $0xc,%esp
80106d93:	68 29 7b 10 80       	push   $0x80107b29
80106d98:	e8 c3 98 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80106d9d:	83 c4 10             	add    $0x10,%esp
80106da0:	8b 45 0c             	mov    0xc(%ebp),%eax
80106da3:	39 45 10             	cmp    %eax,0x10(%ebp)
80106da6:	76 0d                	jbe    80106db5 <allocuvm+0xe5>
80106da8:	89 c1                	mov    %eax,%ecx
80106daa:	8b 55 10             	mov    0x10(%ebp),%edx
80106dad:	8b 45 08             	mov    0x8(%ebp),%eax
80106db0:	e8 7b fb ff ff       	call   80106930 <deallocuvm.part.0>
      kfree(mem);
80106db5:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80106db8:	31 ff                	xor    %edi,%edi
      kfree(mem);
80106dba:	56                   	push   %esi
80106dbb:	e8 60 b5 ff ff       	call   80102320 <kfree>
      return 0;
80106dc0:	83 c4 10             	add    $0x10,%esp
}
80106dc3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106dc6:	89 f8                	mov    %edi,%eax
80106dc8:	5b                   	pop    %ebx
80106dc9:	5e                   	pop    %esi
80106dca:	5f                   	pop    %edi
80106dcb:	5d                   	pop    %ebp
80106dcc:	c3                   	ret    
80106dcd:	8d 76 00             	lea    0x0(%esi),%esi
80106dd0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80106dd3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106dd6:	5b                   	pop    %ebx
80106dd7:	89 f8                	mov    %edi,%eax
80106dd9:	5e                   	pop    %esi
80106dda:	5f                   	pop    %edi
80106ddb:	5d                   	pop    %ebp
80106ddc:	c3                   	ret    
80106ddd:	8d 76 00             	lea    0x0(%esi),%esi
80106de0:	89 c1                	mov    %eax,%ecx
80106de2:	8b 55 10             	mov    0x10(%ebp),%edx
80106de5:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80106de8:	31 ff                	xor    %edi,%edi
80106dea:	e8 41 fb ff ff       	call   80106930 <deallocuvm.part.0>
80106def:	eb 92                	jmp    80106d83 <allocuvm+0xb3>
80106df1:	eb 0d                	jmp    80106e00 <deallocuvm>
80106df3:	90                   	nop
80106df4:	90                   	nop
80106df5:	90                   	nop
80106df6:	90                   	nop
80106df7:	90                   	nop
80106df8:	90                   	nop
80106df9:	90                   	nop
80106dfa:	90                   	nop
80106dfb:	90                   	nop
80106dfc:	90                   	nop
80106dfd:	90                   	nop
80106dfe:	90                   	nop
80106dff:	90                   	nop

80106e00 <deallocuvm>:
{
80106e00:	55                   	push   %ebp
80106e01:	89 e5                	mov    %esp,%ebp
80106e03:	8b 55 0c             	mov    0xc(%ebp),%edx
80106e06:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106e09:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80106e0c:	39 d1                	cmp    %edx,%ecx
80106e0e:	73 10                	jae    80106e20 <deallocuvm+0x20>
}
80106e10:	5d                   	pop    %ebp
80106e11:	e9 1a fb ff ff       	jmp    80106930 <deallocuvm.part.0>
80106e16:	8d 76 00             	lea    0x0(%esi),%esi
80106e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106e20:	89 d0                	mov    %edx,%eax
80106e22:	5d                   	pop    %ebp
80106e23:	c3                   	ret    
80106e24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106e2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106e30 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106e30:	55                   	push   %ebp
80106e31:	89 e5                	mov    %esp,%ebp
80106e33:	57                   	push   %edi
80106e34:	56                   	push   %esi
80106e35:	53                   	push   %ebx
80106e36:	83 ec 0c             	sub    $0xc,%esp
80106e39:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106e3c:	85 f6                	test   %esi,%esi
80106e3e:	74 59                	je     80106e99 <freevm+0x69>
80106e40:	31 c9                	xor    %ecx,%ecx
80106e42:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106e47:	89 f0                	mov    %esi,%eax
80106e49:	e8 e2 fa ff ff       	call   80106930 <deallocuvm.part.0>
80106e4e:	89 f3                	mov    %esi,%ebx
80106e50:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106e56:	eb 0f                	jmp    80106e67 <freevm+0x37>
80106e58:	90                   	nop
80106e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e60:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106e63:	39 fb                	cmp    %edi,%ebx
80106e65:	74 23                	je     80106e8a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106e67:	8b 03                	mov    (%ebx),%eax
80106e69:	a8 01                	test   $0x1,%al
80106e6b:	74 f3                	je     80106e60 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106e6d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80106e72:	83 ec 0c             	sub    $0xc,%esp
80106e75:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106e78:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106e7d:	50                   	push   %eax
80106e7e:	e8 9d b4 ff ff       	call   80102320 <kfree>
80106e83:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106e86:	39 fb                	cmp    %edi,%ebx
80106e88:	75 dd                	jne    80106e67 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80106e8a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106e8d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e90:	5b                   	pop    %ebx
80106e91:	5e                   	pop    %esi
80106e92:	5f                   	pop    %edi
80106e93:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80106e94:	e9 87 b4 ff ff       	jmp    80102320 <kfree>
    panic("freevm: no pgdir");
80106e99:	83 ec 0c             	sub    $0xc,%esp
80106e9c:	68 45 7b 10 80       	push   $0x80107b45
80106ea1:	e8 ea 94 ff ff       	call   80100390 <panic>
80106ea6:	8d 76 00             	lea    0x0(%esi),%esi
80106ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106eb0 <setupkvm>:
{
80106eb0:	55                   	push   %ebp
80106eb1:	89 e5                	mov    %esp,%ebp
80106eb3:	56                   	push   %esi
80106eb4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106eb5:	e8 16 b6 ff ff       	call   801024d0 <kalloc>
80106eba:	85 c0                	test   %eax,%eax
80106ebc:	89 c6                	mov    %eax,%esi
80106ebe:	74 42                	je     80106f02 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80106ec0:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106ec3:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80106ec8:	68 00 10 00 00       	push   $0x1000
80106ecd:	6a 00                	push   $0x0
80106ecf:	50                   	push   %eax
80106ed0:	e8 3b d7 ff ff       	call   80104610 <memset>
80106ed5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80106ed8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106edb:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106ede:	83 ec 08             	sub    $0x8,%esp
80106ee1:	8b 13                	mov    (%ebx),%edx
80106ee3:	ff 73 0c             	pushl  0xc(%ebx)
80106ee6:	50                   	push   %eax
80106ee7:	29 c1                	sub    %eax,%ecx
80106ee9:	89 f0                	mov    %esi,%eax
80106eeb:	e8 b0 f9 ff ff       	call   801068a0 <mappages>
80106ef0:	83 c4 10             	add    $0x10,%esp
80106ef3:	85 c0                	test   %eax,%eax
80106ef5:	78 19                	js     80106f10 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106ef7:	83 c3 10             	add    $0x10,%ebx
80106efa:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106f00:	75 d6                	jne    80106ed8 <setupkvm+0x28>
}
80106f02:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106f05:	89 f0                	mov    %esi,%eax
80106f07:	5b                   	pop    %ebx
80106f08:	5e                   	pop    %esi
80106f09:	5d                   	pop    %ebp
80106f0a:	c3                   	ret    
80106f0b:	90                   	nop
80106f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80106f10:	83 ec 0c             	sub    $0xc,%esp
80106f13:	56                   	push   %esi
      return 0;
80106f14:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80106f16:	e8 15 ff ff ff       	call   80106e30 <freevm>
      return 0;
80106f1b:	83 c4 10             	add    $0x10,%esp
}
80106f1e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106f21:	89 f0                	mov    %esi,%eax
80106f23:	5b                   	pop    %ebx
80106f24:	5e                   	pop    %esi
80106f25:	5d                   	pop    %ebp
80106f26:	c3                   	ret    
80106f27:	89 f6                	mov    %esi,%esi
80106f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106f30 <kvmalloc>:
{
80106f30:	55                   	push   %ebp
80106f31:	89 e5                	mov    %esp,%ebp
80106f33:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106f36:	e8 75 ff ff ff       	call   80106eb0 <setupkvm>
80106f3b:	a3 a4 55 11 80       	mov    %eax,0x801155a4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106f40:	05 00 00 00 80       	add    $0x80000000,%eax
80106f45:	0f 22 d8             	mov    %eax,%cr3
}
80106f48:	c9                   	leave  
80106f49:	c3                   	ret    
80106f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106f50 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106f50:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106f51:	31 c9                	xor    %ecx,%ecx
{
80106f53:	89 e5                	mov    %esp,%ebp
80106f55:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106f58:	8b 55 0c             	mov    0xc(%ebp),%edx
80106f5b:	8b 45 08             	mov    0x8(%ebp),%eax
80106f5e:	e8 bd f8 ff ff       	call   80106820 <walkpgdir>
  if(pte == 0)
80106f63:	85 c0                	test   %eax,%eax
80106f65:	74 05                	je     80106f6c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106f67:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106f6a:	c9                   	leave  
80106f6b:	c3                   	ret    
    panic("clearpteu");
80106f6c:	83 ec 0c             	sub    $0xc,%esp
80106f6f:	68 56 7b 10 80       	push   $0x80107b56
80106f74:	e8 17 94 ff ff       	call   80100390 <panic>
80106f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106f80 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106f80:	55                   	push   %ebp
80106f81:	89 e5                	mov    %esp,%ebp
80106f83:	57                   	push   %edi
80106f84:	56                   	push   %esi
80106f85:	53                   	push   %ebx
80106f86:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106f89:	e8 22 ff ff ff       	call   80106eb0 <setupkvm>
80106f8e:	85 c0                	test   %eax,%eax
80106f90:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106f93:	0f 84 a0 00 00 00    	je     80107039 <copyuvm+0xb9>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106f99:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106f9c:	85 c9                	test   %ecx,%ecx
80106f9e:	0f 84 95 00 00 00    	je     80107039 <copyuvm+0xb9>
80106fa4:	31 f6                	xor    %esi,%esi
80106fa6:	eb 4e                	jmp    80106ff6 <copyuvm+0x76>
80106fa8:	90                   	nop
80106fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106fb0:	83 ec 04             	sub    $0x4,%esp
80106fb3:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80106fb9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106fbc:	68 00 10 00 00       	push   $0x1000
80106fc1:	57                   	push   %edi
80106fc2:	50                   	push   %eax
80106fc3:	e8 f8 d6 ff ff       	call   801046c0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80106fc8:	58                   	pop    %eax
80106fc9:	5a                   	pop    %edx
80106fca:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106fcd:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106fd0:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106fd5:	53                   	push   %ebx
80106fd6:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106fdc:	52                   	push   %edx
80106fdd:	89 f2                	mov    %esi,%edx
80106fdf:	e8 bc f8 ff ff       	call   801068a0 <mappages>
80106fe4:	83 c4 10             	add    $0x10,%esp
80106fe7:	85 c0                	test   %eax,%eax
80106fe9:	78 39                	js     80107024 <copyuvm+0xa4>
  for(i = 0; i < sz; i += PGSIZE){
80106feb:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106ff1:	39 75 0c             	cmp    %esi,0xc(%ebp)
80106ff4:	76 43                	jbe    80107039 <copyuvm+0xb9>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106ff6:	8b 45 08             	mov    0x8(%ebp),%eax
80106ff9:	31 c9                	xor    %ecx,%ecx
80106ffb:	89 f2                	mov    %esi,%edx
80106ffd:	e8 1e f8 ff ff       	call   80106820 <walkpgdir>
80107002:	85 c0                	test   %eax,%eax
80107004:	74 3e                	je     80107044 <copyuvm+0xc4>
    if(!(*pte & PTE_P))
80107006:	8b 18                	mov    (%eax),%ebx
80107008:	f6 c3 01             	test   $0x1,%bl
8010700b:	74 44                	je     80107051 <copyuvm+0xd1>
    pa = PTE_ADDR(*pte);
8010700d:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
8010700f:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    pa = PTE_ADDR(*pte);
80107015:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
8010701b:	e8 b0 b4 ff ff       	call   801024d0 <kalloc>
80107020:	85 c0                	test   %eax,%eax
80107022:	75 8c                	jne    80106fb0 <copyuvm+0x30>
      goto bad;
  }
  return d;

bad:
  freevm(d);
80107024:	83 ec 0c             	sub    $0xc,%esp
80107027:	ff 75 e0             	pushl  -0x20(%ebp)
8010702a:	e8 01 fe ff ff       	call   80106e30 <freevm>
  return 0;
8010702f:	83 c4 10             	add    $0x10,%esp
80107032:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80107039:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010703c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010703f:	5b                   	pop    %ebx
80107040:	5e                   	pop    %esi
80107041:	5f                   	pop    %edi
80107042:	5d                   	pop    %ebp
80107043:	c3                   	ret    
      panic("copyuvm: pte should exist");
80107044:	83 ec 0c             	sub    $0xc,%esp
80107047:	68 60 7b 10 80       	push   $0x80107b60
8010704c:	e8 3f 93 ff ff       	call   80100390 <panic>
      panic("copyuvm: page not present");
80107051:	83 ec 0c             	sub    $0xc,%esp
80107054:	68 7a 7b 10 80       	push   $0x80107b7a
80107059:	e8 32 93 ff ff       	call   80100390 <panic>
8010705e:	66 90                	xchg   %ax,%ax

80107060 <uva2ka>:

// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107060:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107061:	31 c9                	xor    %ecx,%ecx
{
80107063:	89 e5                	mov    %esp,%ebp
80107065:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107068:	8b 55 0c             	mov    0xc(%ebp),%edx
8010706b:	8b 45 08             	mov    0x8(%ebp),%eax
8010706e:	e8 ad f7 ff ff       	call   80106820 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107073:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107075:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107076:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107078:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
8010707d:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107080:	05 00 00 00 80       	add    $0x80000000,%eax
80107085:	83 fa 05             	cmp    $0x5,%edx
80107088:	ba 00 00 00 00       	mov    $0x0,%edx
8010708d:	0f 45 c2             	cmovne %edx,%eax
}
80107090:	c3                   	ret    
80107091:	eb 0d                	jmp    801070a0 <copyout>
80107093:	90                   	nop
80107094:	90                   	nop
80107095:	90                   	nop
80107096:	90                   	nop
80107097:	90                   	nop
80107098:	90                   	nop
80107099:	90                   	nop
8010709a:	90                   	nop
8010709b:	90                   	nop
8010709c:	90                   	nop
8010709d:	90                   	nop
8010709e:	90                   	nop
8010709f:	90                   	nop

801070a0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801070a0:	55                   	push   %ebp
801070a1:	89 e5                	mov    %esp,%ebp
801070a3:	57                   	push   %edi
801070a4:	56                   	push   %esi
801070a5:	53                   	push   %ebx
801070a6:	83 ec 1c             	sub    $0x1c,%esp
801070a9:	8b 5d 14             	mov    0x14(%ebp),%ebx
801070ac:	8b 55 0c             	mov    0xc(%ebp),%edx
801070af:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801070b2:	85 db                	test   %ebx,%ebx
801070b4:	75 40                	jne    801070f6 <copyout+0x56>
801070b6:	eb 70                	jmp    80107128 <copyout+0x88>
801070b8:	90                   	nop
801070b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801070c0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801070c3:	89 f1                	mov    %esi,%ecx
801070c5:	29 d1                	sub    %edx,%ecx
801070c7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
801070cd:	39 d9                	cmp    %ebx,%ecx
801070cf:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801070d2:	29 f2                	sub    %esi,%edx
801070d4:	83 ec 04             	sub    $0x4,%esp
801070d7:	01 d0                	add    %edx,%eax
801070d9:	51                   	push   %ecx
801070da:	57                   	push   %edi
801070db:	50                   	push   %eax
801070dc:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801070df:	e8 dc d5 ff ff       	call   801046c0 <memmove>
    len -= n;
    buf += n;
801070e4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
801070e7:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
801070ea:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
801070f0:	01 cf                	add    %ecx,%edi
  while(len > 0){
801070f2:	29 cb                	sub    %ecx,%ebx
801070f4:	74 32                	je     80107128 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
801070f6:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801070f8:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
801070fb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801070fe:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107104:	56                   	push   %esi
80107105:	ff 75 08             	pushl  0x8(%ebp)
80107108:	e8 53 ff ff ff       	call   80107060 <uva2ka>
    if(pa0 == 0)
8010710d:	83 c4 10             	add    $0x10,%esp
80107110:	85 c0                	test   %eax,%eax
80107112:	75 ac                	jne    801070c0 <copyout+0x20>
  }
  return 0;
}
80107114:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107117:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010711c:	5b                   	pop    %ebx
8010711d:	5e                   	pop    %esi
8010711e:	5f                   	pop    %edi
8010711f:	5d                   	pop    %ebp
80107120:	c3                   	ret    
80107121:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107128:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010712b:	31 c0                	xor    %eax,%eax
}
8010712d:	5b                   	pop    %ebx
8010712e:	5e                   	pop    %esi
8010712f:	5f                   	pop    %edi
80107130:	5d                   	pop    %ebp
80107131:	c3                   	ret    
