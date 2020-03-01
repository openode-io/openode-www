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
      return p;
    }
  },
  ls: {
    description: 'List file on a given directory',
    ls(pushToList, path="/") {
      const p = new Promise((resolve, reject) => {
        pushToList({ type: 'success', label: 'Success', message: path })
        resolve({ type: 'success', label: '', message: '' })
      })
      
      return p;
    }
  },
  logs: {
    description: 'Return logs for a given instance',
    logs(pushToList, n="10") {
      const p = new Promise((resolve, reject) => {
        pushToList({ type: 'info', label: 'Info', message: "Loading logs..." })
        resolve({ type: 'success', label: 'Success', message: "Latest " + n + " lines..." })
      })            
      
      return p;      
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
  },
  defaultTask: {
    description: 'Welcome to opeNode',
    defaultTask(pushToList){
      const p = new Promise((resolve, reject) => {
        pushToList({ type: 'info', label: 'Info', message: 'Initializing...' })

        setTimeout(function(){
          resolve({ type: 'success', label: 'Success', message: 'Ready!' })
        },2000);
      })            
      
      return p;
    }
  }

}

export const commandList = {
  version: {
    description: 'Return opeNode API version',
    messages: [
      { message: '1.0.0' }
    ]
  }
}