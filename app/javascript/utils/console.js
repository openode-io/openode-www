// DOCS: https://github.com/dongsuo/vue-terminal/
// const USER_ID = parseInt(Math.random() * 1000)

function generateTime() {
  const timeNow = new Date();
  const hours = timeNow.getHours();
  const minutes = timeNow.getMinutes();
  const seconds = timeNow.getSeconds();
  let timeString = '' + hours;
  timeString += (minutes < 10 ? ':0' : ':') + minutes;
  timeString += (seconds < 10 ? ':0' : ':') + seconds;
  return timeString
}

export const mockData = [
  { time: generateTime(),
    type: 'system',
    label: 'System',
    message: 'You can use this terminal to run commands or return logs.' },
    { time: generateTime(), type: 'info', label: 'Info', message: 'Terminal Initializing...' },
    { time: generateTime(), type: 'success', label: 'Success', message: 'Everything OK!' }
]

export const taskList = {
  echo: {
    description: 'Echoes input',
    echo(pushToList, input) {
      input = input.split(' ')
      input.splice(0, 1)
      const p = new Promise(resolve => {
        pushToList({ time: generateTime(), label: 'Echo', type: 'success', message: input.join(' ') });
        resolve({ type: 'success', label: '', message: '' })
      })
      return p
    }
  },
  defaultTask: {
    description: 'this is default task.',
    defaultTask(pushToList) {
      let i = 0;
      const p = new Promise(resolve => {
        const interval = setInterval(() => {
          mockData[i].time = generateTime()
          pushToList(mockData[i]);
          i++
          if (!mockData[i]) {
            clearInterval(interval)
            resolve({ type: 'success', label: 'Success', message: 'Example Over!' })
          }
        }, 1000);
      })
      return p
    }
  },
  open: {
    description: 'Open a specified url in a new tab.',
    open(pushToList, input) {
      const p = new Promise((resolve, reject) => {
        let url = input.split(' ')[1]
        if (!url) {
          reject({ type: 'error', label: 'Error', message: 'a url is required!' })
          return
        }
        pushToList({ type: 'success', label: 'Success', message: 'Opening' })

        if (input.split(' ')[1].indexOf('http') === -1) {
          url = 'http://' + input.split(' ')[1]
        }
        window.open(url, '_blank')
        resolve({ type: 'success', label: 'Done', message: 'Page Opened!' })
      })
      return p;
    }
  }

}

export const commandList = {
  version: {
    description: 'Return this project version',
    messages: [
      { message: '1.0.0' }
    ]
  },
  contact: {
    description: 'How to contact author',
    messages: [
    { message: 'Website: http://xiaofeixu.cn' },
    { message: 'Email: xuxiaofei915@gmail.com' },
    { message: 'Github: https://github.com/dongsuo' },
    { message: 'WeChat Offical Account: dongsuo' }
    ] },
  about: {
    description: 'About author',
    messages: [
    { message: 'My name is xu xiaofei. I\'m a programmer, You can visit my personal website at http://xiaofeixu.cn to learn more about me.' }
    ]
  },
  readme: {
    description: 'About this project.',
    messages: [
    { message: 'This is a component that emulates a command terminal in Vue' }
    ] },
  document: {
    description: 'Document of this project.',
    messages: [
      { message: {
        text: 'Under Construction',
        list: [
        { label: 'hello', type: 'error', message: 'this is a test message' }
        ]
      } }]
  }
}