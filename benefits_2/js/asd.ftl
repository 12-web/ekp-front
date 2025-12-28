<#if entries?has_content>
  <div class="row">
    <#list entries?reverse as curEntry>
      <#assign articleId = curEntry.getClassPK()?string />
      <#assign docXml = saxReaderUtil.read(curEntry.getAssetRenderer().getArticle().getContent()) />
      <#assign titleName = curEntry.getTitle(locale) />
      <#assign fieldValLinkPage = docXml.valueOf("//dynamic-element[@name='linkPage']/dynamic-content/text()") />
      <#assign fieldValDeskPage = docXml.valueOf("//dynamic-element[@name='deskPage']/dynamic-content/text()") />
      <#assign fieldValClosingInterval = docXml.valueOf("//dynamic-element[@name='closingInterval']/dynamic-content/text()") />
      <#assign fieldValShowClose = docXml.valueOf("//dynamic-element[@name='showClose']/dynamic-content/text()") />
      <#assign fieldValVisibleModalWindow = docXml.valueOf("//dynamic-element[@name='visibleModalWindow']/dynamic-content/text()") />
      <#assign fieldValWidthWindow = docXml.valueOf("//dynamic-element[@name='widthWindow']/dynamic-content/text()") />
      <#assign fieldValHeightWindow = docXml.valueOf("//dynamic-element[@name='heightWindow']/dynamic-content/text()") />
      <#assign fieldValShowTitle = docXml.valueOf("//dynamic-element[@name='showTitle']/dynamic-content/text()") />
      <#assign fieldValActiveWindow = docXml.valueOf("//dynamic-element[@name='activeWindow']/dynamic-content/text()") />

      <#if fieldValActiveWindow == "true">
        <#assign modalId = "customModal_" + articleId />

        <div id="${modalId}" class="custom-modal" aria-hidden="true">
          <div class="custom-modal__overlay" tabindex="-1">
            <div class="custom-modal__container" style="width:${fieldValWidthWindow}; height:${fieldValHeightWindow}" role="dialog" aria-modal="true">
              <div class="custom-modal__content">
                <div class="custom-modal__header">
                  <#if fieldValShowTitle == "true">
                    <h1 class="custom-modal__title">${titleName}</h1>
                  </#if>
                  <div class="close-container">
                    <button type="button" class="custom-modal__close-btn" id="closeButton_${modalId}" style="opacity:0; pointer-events:none;">
                      ✕
                    </button>
                    <div id="timerCircle_${modalId}" class="timer-circle">
                      <svg class="progress-ring" width="40" height="40">
                        <circle class="progress-ring__background" cx="20" cy="20" r="16" stroke-width="3" fill="transparent"/>
                        <circle class="progress-ring__progress" cx="20" cy="20" r="16" stroke="#00395CCC" stroke-width="3" fill="transparent" stroke-dasharray="100.53" stroke-dashoffset="100.53" transform="rotate(-90 20 20)"/>
                      </svg>
                      <span id="timerText_${modalId}" class="timer-text">${fieldValShowClose!}</span>
                    </div>
                  </div>
                </div>
                <div class="custom-modal__body">${fieldValDeskPage}</div>
                <div class="custom-modal__footer">
                  <a href="${fieldValLinkPage}" target="_blank">
                      <button type="button" class="btn btn-primary">
                          Подробнее
                          <svg xmlns="http://www.w3.org/2000/svg" width="13" height="12" viewBox="0 0 13 12" fill="none">
                              <path d="M8.5942 4.71132L5.29709 1.41421L6.7113 0L12.4226 5.71132L6.7113 11.4226L5.29709 10.0084L8.59421 6.71132H0V4.71132H8.5942Z" fill="white"/>
                          </svg>
                      </button>
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>

        <script>
          window.customModal = window.customModal || { registeredModals: [] };
          window.customModal.registeredModals.push({modalId: "${modalId}",
            entryId: "${curEntry.getEntryId()}",
            mode: "${fieldValVisibleModalWindow!'always'}",
            closingInterval: ${fieldValClosingInterval?has_content?then(fieldValClosingInterval,0)},
            showClose: ${fieldValShowClose?has_content?then(fieldValShowClose,0)}
          });
        </script>

      </#if>
    </#list>
  </div>

  <style>
    .custom-modal {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      z-index: 1000;
      display: flex;
      align-items: center;
      justify-content: center;
      opacity: 0;
      pointer-events: none;
      transition: opacity 0.3s ease;
    }

    .custom-modal[aria-hidden="false"] {
      opacity: 1;
      pointer-events: all;
    }

    .custom-modal__overlay {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0,0,0,0.5);
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .custom-modal__container {
      background-color: #fff;
      border-radius: 4px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.2);
      max-width: 90%;
      max-height: 90vh;
      overflow: hidden;
      position: relative;
      transform: translateY(-20px);
      opacity: 0;
      transition: all 0.3s ease-out;
    }

    .custom-modal[aria-hidden="false"] .custom-modal__container {
      transform: translateY(0);
      opacity: 1;
    }

    .custom-modal__content {
      display: flex;
      flex-direction: column;
      height: 100%;
    }

    .custom-modal__header {
      padding: 24px 32px 0 24px;
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      flex-shrink: 0;
    }

    .custom-modal__title {
      font-size: 1.5rem;
      font-weight: 400;
      margin: 0;
      flex: 1;
    }

    .custom-modal__body {
      word-break: break-word;
      padding: 20px 24px;
      overflow-y: auto;
      flex: 1;
    }

    .custom-modal__footer {
      padding: 0 32px 32px 24px;
      display: flex;
      justify-content: flex-end;
      flex-shrink: 0;
    }

    .custom-modal__close-btn {
      background: transparent;
      border: none;
      cursor: pointer;
      padding: 8px;
      margin: -8px;
      position: relative;
      z-index: 1;
    }

    .close-container {
      position: relative;
      width: 40px;
      height: 40px;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-left: auto;
    }

    .timer-circle {
      position: relative;
      width: 40px;
      height: 40px;
    }

    .progress-ring {
      position: absolute;
      top: 2px;
      left: -28px;
      width: 40px;
      height: 40px;
    }

    .progress-ring__background {
      stroke: #e0e0e0;
    }

    .progress-ring__progress {
      transition: stroke-dashoffset 0.1s linear;
    }

    .timer-text {
      position: absolute;
      top: 22px;
      left: -8px;
      transform: translate(-50%, -50%);
      font-size: 14px;
      font-weight: bold;
      color: #00395CCC;
      z-index: 2;
    }

    /* Скрыть в редакторе */
    .page-editor__topper .custom-modal {
      display: none !important;
    }
  </style>

  <script>
    (function(){
      if (window.customModal._initialized) return;
      window.customModal._initialized = true;

      const priorityOrder = {once:0, daily:1, always:2};
      const modals = window.customModal.registeredModals.sort((a,b) => priorityOrder[a.mode] - priorityOrder[b.mode]);

      function canShow(m){const today = new Date().toISOString().slice(0,10);
        if (m.mode === "once") return localStorage.getItem("modal_once_" + m.entryId) !== "shown";
        if (m.mode === "daily") return localStorage.getItem("modal_daily_" + m.entryId) !== today;
        return true;
      }

    function markShown(m){
        const today = new Date().toISOString().slice(0,10);
        if (m.mode === "once") localStorage.setItem("modal_once_" + m.entryId, "shown");
        if (m.mode === "daily") localStorage.setItem("modal_daily_" + m.entryId, today);
      }

      function openModal(m){
        const modalEl = document.getElementById(m.modalId);
        if (!modalEl) return;

        modalEl.setAttribute("aria-hidden","false");
        document.body.style.overflow="hidden";

        const closeButton = document.getElementById('closeButton_' + m.modalId);
        const timerCircle = document.getElementById('timerCircle_' + m.modalId);
        const timerText = document.getElementById('timerText_' + m.modalId);
        const progressCircle = timerCircle ? timerCircle.querySelector('.progress-ring__progress') : null;

        let allowClose = false;
        function enableClose(){ allowClose=true; if(closeButton){closeButton.style.opacity='1'; closeButton.style.pointerEvents='all';} }
        function closeModal(){ modalEl.setAttribute("aria-hidden","true"); document.body.style.overflow=""; }
        if(closeButton) closeButton.addEventListener('click',()=>{ if(allowClose) closeModal(); });

        if(m.closingInterval && m.closingInterval>0) setTimeout(()=>{ enableClose(); closeModal(); }, m.closingInterval*1000)
        else { if(timerCircle) timerCircle.classList.add; }

        if(m.showClose && m.showClose>0 && progressCircle && timerText){
          const radius=16, circ=2*Math.PI*radius, start=Date.now(), total=m.showClose*1000;
          progressCircle.style.strokeDasharray=circ;
          progressCircle.style.strokeDashoffset=circ;
          function animate(){
            const elapsed=Date.now()-start;
            const p=Math.min(elapsed/total,1);
            progressCircle.style.strokeDashoffset=circ-(p*circ);
            timerText.textContent=Math.ceil(m.showClose-p*m.showClose);
            if(p<1) requestAnimationFrame(animate);
            else { if(timerCircle) timerCircle.style.display='none'; enableClose(); }
          }
          requestAnimationFrame(animate);
        } else enableClose();
      }

      for(const m of modals){
        if(canShow(m)){
          markShown(m);
          openModal(m);
          break; // показываем только одно окно
        }
      }
    })();
  </script>
</#if>
