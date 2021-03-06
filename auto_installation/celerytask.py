import attr
from celery import Celery


@attr.s
class RhvhTask(object):
    cfg = attr.ib(default=dict(
        timezone="Asia/Shanghai",
        include=[
            'tasker.tasks', 'tasker.rhvm_upgrade', 'tasker.rhvh_auto',
            'tasker.rhvh_bug_query_report', 'tasker.rhvh_upgrade'
        ],
        result_backend='redis://:redhat@10.73.73.23:6379/12',
        broker_url='pyamqp://rhvher:rhvher@10.73.73.23/celery'))

    @property
    def c(self):
        _c = Celery()
        _c.config_from_object(self.cfg)
        return _c

    def simple(self):
        self.c.send_task('tasker.tasks.add', (2, 2))

    def lanuchAuto(self, build_name, pxe, ts_level, target_build):
        self.c.send_task('tasker.rhvh_auto.launch_autotesting',
                         (build_name, pxe, ts_level, target_build))

    def lanuchCockpitAuto(self):
        self.c.send_task('tasker.rhvh_auto.launch_cockpit')

    def lanuchUpgrade(self, tasks):
        self.c.send_task('tasker.rhvh_upgrade.lanuch_upgrade', tasks)


if __name__ == '__main__':
    rt = RhvhTask()
    rt.lanuchUpgrade()
