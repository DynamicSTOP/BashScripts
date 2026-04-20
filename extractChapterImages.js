(async () => {
  console.clear();

  const images = Array.from(document.querySelectorAll('img')).filter(img => img.src.startsWith('blob'))

  const container = document.createElement('div');
  document.body.append(container);

  const addAndDownload = (image, pref) => new Promise(async (resolve) => {
    try {
      const res = await fetch(image.src);
      const blb = await res.blob();
      const ext = blb.type.replace('image/', '');

      const a = document.createElement('A');
      a.innerText = `${pref}.${ext}`;
      a.download = `${pref}.${ext}`;
      a.href = image.src;
      container.append(a);
      a.click();
    } catch (e) {
      console.error(e);
    }
    resolve();
  });

  let name = 'Title'
  const chapter = 1;

  try {
    let id = 1;
    let ch = chapter.toString().padStart(chapter % 1 === 0 ? 3 : 5, 0);
    for (image of images) {
      let num = id.toString().padStart(3, '0');
      let pref = `${name}_ch${ch}_p${num}`;
      await addAndDownload(image, pref);
      id++;
    }

  } catch (e) {
    console.error(e);
  }

  setTimeout(() => { container.remove() }, 30000);
})();


(async () => {
  console.clear();

  const images = Array.from(document.querySelectorAll('.image_orientation img'))

  const container = document.createElement('div');
  document.body.append(container);


  let txt = '';

  const addAndDownload = (image, pref) => new Promise(async (resolve) => {
    txt += `curl ${image.src} > ~/images/${pref.replace(/\s/g, '\\ ')}.jpg ;\n\n`
    resolve();
  });

  let name = 'Title'
  const chapter = 1;

  try {
    let id = 1;
    let ch = chapter.toString().padStart(chapter % 1 === 0 ? 3 : 5, 0);
    for (image of images) {
      let num = id.toString().padStart(3, '0');
      let pref = `${name}_ch${ch}_p${num}`;
      await addAndDownload(image, pref);
      id++;
    }

  } catch (e) {
    console.error(e);
  }
  console.log(txt);
})();
